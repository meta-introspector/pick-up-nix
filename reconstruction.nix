{
  description = "Reconstructs the nested Nix environment for Gemini CLI within Rust Nix within pick-up-nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Reference the main pick-up-nix project flake
    pick-up-nix.url = "path:."; # Assumes this flake is in the root of pick-up-nix

    # Reference the rust-nix flake
    rust-nix.url = "path:vendor/external/rust/src/tools/nix-dev-shell";

    # Reference the gemini-cli flake
    gemini-cli.url = "path:vendor/external/gemini-cli";
  };

  outputs = { self, nixpkgs, pick-up-nix, rust-nix, gemini-cli }: {
    devShells.aarch64-linux.default = pick-up-nix.devShells.aarch64-linux.default;
  };
}