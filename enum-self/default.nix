{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-23.11.tar.gz") {} }:

let
  rust-overlay = import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz");
  myPkgs = import pkgs.path {
    overlays = [ rust-overlay ];
    config = { };
  };
in
myPkgs.rustPlatform.buildRustPackage {
  pname = "enum-self";
  version = "0.1.0";

  src = ./.;

  # Use cargoHash instead of cargoLock
  cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

  # If you need a specific Rust toolchain (e.g., nightly), uncomment and adjust:
  # rustToolchain = myPkgs.rust-bin.nightly.latest.default;

  meta = with myPkgs.lib; {
    description = "A Rust crate for codifying project structure into enums.";
    homepage = "https://github.com/your-repo/enum-self"; # Replace with actual homepage
    license = licenses.mit; # Or licenses.apache20
    platforms = platforms.linux;
  };
}