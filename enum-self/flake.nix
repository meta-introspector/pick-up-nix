{
  description = "Nix flake for the enum-self Rust crate";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # Use a stable nixpkgs
    naersk.url = "github:nix-community/naersk/master"; # Use naersk
    flake-utils.url = "github:numtide/flake-utils"; # For easier cross-platform builds
    syn-wrapper = { url = "path:../wrappers/syn-wrapper"; flake = false; };
  };

    outputs = { self, flake-utils, naersk, nixpkgs, syn-wrapper }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        naersk' = pkgs.callPackage naersk {}; # Correct way to get naersk's functions

        synWrapperPackage = naersk'.buildPackage {
          pname = "syn-wrapper";
          version = "0.1.0";
          src = builtins.path { path = inputs.syn-wrapper; };
          cargoLock.lockFile = builtins.path { path = inputs.syn-wrapper + "/Cargo.lock"; };
        };

      in rec {
        # For `nix build` & `nix run`:
        defaultPackage = naersk'.buildPackage {
          src = ./.;
          pname = "enum-self"; # Add pname and version
          version = "0.1.0";

          # This will automatically use the Cargo.lock from the source directory
          # If your Cargo.lock is in the parent directory, you might need:
          cargoLock = ./Cargo.lock;
          buildInputs = [ inputs.syn-wrapper ];

          # If you need a specific Rust toolchain (e.g., nightly), uncomment and adjust:
          # rustToolchain = pkgs.rust-bin.nightly.latest.default;

          meta = with pkgs.lib; {
            description = "A Rust crate for codifying project structure into enums.";
            homepage = "https://github.com/your-repo/enum-self"; # Replace with actual homepage
            license = licenses.mit; # Or licenses.apache20
            platforms = platforms.linux;
          };
        };

        # For `nix develop`:
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ rustc cargo ];
        };
      }
    );
}
