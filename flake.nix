{
  description = "A minimal development environment for Rust projects.";

  inputs = {
    nixpkgs.url = "github:meta-introspector/nixpkgs?ref=feature/CRQ-016-nixify";
    flake-utils.url = "github:meta-introspector/flake-utils?ref=feature/CRQ-016-nixify";
    naersk.url = "github:meta-introspector/naersk?ref=feature/CRQ-016-nixify";
    #    my-new-flake.url = "./nix/flakes/my-new-flake";
    flake-parts.url = "github:meta-introspector/flake-parts?ref=feature/CRQ-016-nixify"; # Corrected URL
    git-hooks.url = "path:/data/data/com.termux.nix/files/home/nix/vendor/hooks/git-hooks.nix"; # New input for git-hooks
    rust-overlay.url = "github:meta-introspector/rust-overlay?ref=feature/CRQ-016-nixify"; # Corrected rust-overlay input
    gemini-cli.url = "github:meta-introspector/gemini-cli?ref=feature/CRQ-016-nixify"; # Add gemini-cli input
    rustBootstrapNix.url = "github:meta-introspector/rust-bootstrap-nix?ref=feature/bootstrap-001"; # Reference rust-bootstrap-nix from GitHub
    #    template-generator-bin.url = "./tools/template_generator_bin"; # Keep this input
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , rust-overlay
    , naersk
      #    , my-new-flake
    , flake-parts
    , git-hooks
    , gemini-cli
    , rustBootstrapNix
      #,
      #template-generator-bin
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          rust-overlay.overlays.default
        ];
      };

      naerskLib = naersk.lib.${system};

      # Define an array of Rust versions for testing
      rustVersions = {
        stable = pkgs.rust-bin.stable.latest.default;
        nightly_2025_09_16 = pkgs.rust-bin.nightly."2025-09-16".default; # Our pinned nightly
        # Add more versions here as needed
      };
    in
    rec {
      # logAnalyzer = naerskLib.buildPackage {
      #   pname = "log-analyzer";
      #   version = "0.1.0";
      #   src = self + "/crates/log_analyzer";
      #   cargoLock = {
      #     lockFile = ./crates/log_analyzer/Cargo.lock;
      #   };
      # };
      packages = {
        # Re-add the packages section
        # log-analyzer = logAnalyzer;
        #        my-new-flake = my-new-flake.packages.${system}.default;
        #        default = my-new-flake.packages.${system}.default; # Set my-new-flake as the default package
      };

      # apps.log-analyzer = flake-utils.lib.mkApp {
      #   drv = logAnalyzer;
      # };

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          rustVersions.nightly_2025_09_16 # Use the pinned nightly toolchain
          #            self.packages.${system}.template-generator-bin # Add template-generator-bin to devShell
          which
          gawk # For awk
          jq
          asciinema
          ncurses # Added ncurses
          vale
          gnupg
          pinentry
          gemini-cli.packages.${system}.default # Add gemini-cli to devShell
        ];
        shellHook = git-hooks.devShells.${system}.default.shellHook; # Integrate git-hooks shellHook
      };

      # Expose the rustVersions for easy access
      inherit rustVersions;
    }
    );
} # eof
