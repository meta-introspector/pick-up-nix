use std::fs;
use std::path::PathBuf;
use walkdir::WalkDir;
use chrono::{DateTime, Local};
use serde::Deserialize;
use std::io::Read;
use std::env;

#[derive(Debug, Deserialize)]
struct Config {
    paths: PathsConfig,
}

#[derive(Debug, Deserialize)]
struct PathsConfig {
    gemini_logs_dir: String,
    asciinema_recordings_dir: String,
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <path_to_config.toml>", args[0]);
        return Ok(())
    }

    let config_file_path = &args[1];

    // Read the configuration file
    let mut file = fs::File::open(config_file_path)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let config: Config = toml::from_str(&contents)?;

    println!("Listing files in Gemini logs directory: {}", config.paths.gemini_logs_dir);
    list_files_in_dir(&config.paths.gemini_logs_dir)?;

    println!("\nListing files in Asciinema recordings directory: {}", config.paths.asciinema_recordings_dir);
    list_files_in_dir(&config.paths.asciinema_recordings_dir)?;

    Ok(())
}

fn list_files_in_dir(dir_path: &str) -> Result<(), Box<dyn std::error::Error>> {
    for entry in WalkDir::new(dir_path) {
        let entry = entry?;
        let path = entry.path();

        if path.is_file() {
            let metadata = fs::metadata(path)?;
            let modified_time: DateTime<Local> = DateTime::from(metadata.modified()?);
            println!("File: {:<50} Modified: {}", path.display(), modified_time.format("%Y-%m-%d %H:%M:%S"));
        }
    }
    Ok(())
}