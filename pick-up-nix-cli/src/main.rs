use clap::Parser;
use std::fs;
use std::path::Path;
use std::process::Command;

mod events; // Make the events module visible
mod generator; // Make the generator module visible

/// The nix-introspector: A tool to manage and analyze Nix projects.
#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Parser, Debug)]
enum Commands {
    /// Evaluates a new tool according to the SOP.
    Evaluate {
        /// The git URL of the tool to evaluate.
        #[arg(short, long)]
        url: String,
    },
    /// Traces a command using the StraceGenerator.
    Trace {
        /// The command to trace.
        command: String,
        /// Arguments for the command to trace.
        args: Vec<String>,
    },
    /// Traces a nix command using the StraceGenerator.
    TraceNix {
        /// Arguments for the nix command to trace.
        args: Vec<String>,
    },
}

/// Extracts a project name from a git URL.
/// e.g., "https://github.com/nixos/nix.git" -> "nix"
fn get_project_name_from_url(url: &str) -> Option<&str> {
    url.split('/')
        .last()
        .map(|name| name.trim_end_matches(".git"))
}

const FLAKE_NIX_TEMPLATE: &str = r#"{
  description = "A temporary environment for evaluating a tool.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
    
    # The tool to be evaluated
    eval_tool.url = "{TOOL_URL}";
  };

  outputs = { self, nixpkgs, flake-utils, eval_tool }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [ eval_tool.packages.${system}.default ];
        };
      }
    );
}
"#;

fn main() {
    let cli = Cli::parse();

    match &cli.command {
        Commands::Evaluate { url } => {
            println!("Evaluating tool from URL: {}", url);

            let project_name = match get_project_name_from_url(url) {
                Some(name) => name,
                None => {
                    eprintln!("Could not parse project name from URL.");
                    std::process::exit(1);
                }
            };

            println!("Project name: {}", project_name);

            let experiment_path = Path::new("experiments").join(project_name);

            println!("Creating experiment directory at: {:?}", experiment_path);

            if let Err(e) = fs::create_dir_all(&experiment_path) {
                eprintln!("Failed to create experiment directory: {}", e);
                std::process::exit(1);
            }

            println!("Successfully created experiment directory.");

            println!("Generating flake.nix for the experiment.");

            let flake_nix_path = experiment_path.join("flake.nix");
            let flake_content = FLAKE_NIX_TEMPLATE.replace("{TOOL_URL}", url);

            if let Err(e) = fs::write(&flake_nix_path, flake_content) {
                eprintln!("Failed to write flake.nix: {}", e);
                std::process::exit(1);
            }

            println!("Successfully generated flake.nix at: {:?}", flake_nix_path);

            println!("Adding tool as git submodule for vendorization.");

            let vendor_path = Path::new("vendor").join("external");
            if let Err(e) = fs::create_dir_all(&vendor_path) {
                eprintln!("Failed to create vendor/external directory: {}", e);
                std::process::exit(1);
            }

            let submodule_path = vendor_path.join(project_name);
            let submodule_url = url; // Use the original URL

            println!("Adding submodule: {} at {:?}", submodule_url, submodule_path);

            let output = Command::new("git")
                .arg("submodule")
                .arg("add")
                .arg(submodule_url)
                .arg(&submodule_path)
                .output();

            match output {
                Ok(output) => {
                    if output.status.success() {
                        println!("Successfully added submodule.");
                    } else {
                        eprintln!("Failed to add submodule: {}", String::from_utf8_lossy(&output.stderr));
                        std::process::exit(1);
                    }
                }
                Err(e) => {
                    eprintln!("Failed to execute git command: {}", e);
                    std::process::exit(1);
                }
            }

            println!("Copying test cases into experiment directory.");

            let test_cases_path = experiment_path.join("test_cases");
            if let Err(e) = fs::create_dir_all(&test_cases_path) {
                eprintln!("Failed to create test_cases directory: {}", e);
                std::process::exit(1);
            }

            // Copy "bad code" (our broken home/*.nix files)
            let bad_code_files = [
                "home/base.nix",
                "home/emacs.nix",
                "home/scientific.nix",
            ];

            for file_path in &bad_code_files {
                let src_path = Path::new(file_path);
                let dest_path = test_cases_path.join(src_path.file_name().unwrap());
                if let Err(e) = fs::copy(src_path, &dest_path) {
                    eprintln!("Failed to copy {}: {}", src_path.display(), e);
                    // Don't exit, just report, as some might not exist if previous steps failed.
                } else {
                    println!("Copied {} to {:?}", src_path.display(), dest_path);
                }
            }

            // Copy "good code" (main flake.nix)
            let good_code_flake = Path::new("flake.nix");
            let dest_flake_path = test_cases_path.join("main_flake.nix");
            if let Err(e) = fs::copy(good_code_flake, &dest_flake_path) {
                eprintln!("Failed to copy {}: {}", good_code_flake.display(), e);
            } else {
                println!("Copied {} to {:?}", good_code_flake.display(), dest_flake_path);
            }

            println!("Test cases copied.");

            println!("Executing tool against test cases.");

            let experiment_flake_path_str = experiment_path.to_str().unwrap();

            // Iterate over test cases and run the tool
            for entry in fs::read_dir(&test_cases_path).unwrap() {
                let entry = entry.unwrap();
                let test_file_path = entry.path();
                if test_file_path.is_file() {
                    println!("Running tool on test case: {:?}", test_file_path);

                    // Command to run the evaluated tool from the experiment flake's devShell
                    // This assumes the tool is runnable directly and takes a file path as argument
                    let output = Command::new("nix")
                        .arg("run")
                        .arg(format!("path:./{}#eval_tool", experiment_flake_path_str))
                        .arg("--")
                        .arg(&test_file_path)
                        .output();

                    match output {
                        Ok(output) => {
                            println!("--- STDOUT ---");
                            println!("{}", String::from_utf8_lossy(&output.stdout));
                            println!("--- STDERR ---");
                            println!("{}", String::from_utf8_lossy(&output.stderr));
                            println!("--- STATUS ---");
                            println!("Exit Code: {:?}", output.status.code());
                        }
                        Err(e) => {
                            eprintln!("Failed to execute tool on {:?}: {}", test_file_path, e);
                        }
                    }
                }
            }

            println!("Tool execution complete.");
        }
        Commands::Trace { command, args } => {
            println!("Starting trace for command: {} {}", command, args.join(" "));
            let generator = generator::StraceGenerator::new();
            let args_str: Vec<&str> = args.iter().map(|s| s.as_str()).collect();
            match generator.trace_command(command, &args_str) {
                Ok(events) => {
                    println!("Captured {} system events.", events.len());
                    // TODO: Process events (e.g., print, send to eBPF consumer)
                }
                Err(e) => {
                    eprintln!("Tracing failed: {}", e);
                }
            }
        }
        Commands::TraceNix { args } => {
            println!("Starting trace for nix command: {}", args.join(" "));
            let generator = generator::StraceGenerator::new();
            let args_str: Vec<&str> = args.iter().map(|s| s.as_str()).collect();
            match generator.trace_command("nix", &args_str) {
                Ok(events) => {
                    println!("Captured {} system events.", events.len());
                    // TODO: Process events (e.g., print, send to eBPF consumer)
                }
                Err(e) => {
                    eprintln!("Tracing failed: {}", e);
                }
            }
        }
    }
}