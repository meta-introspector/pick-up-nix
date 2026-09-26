{ pkgs ? import <nixpkgs> {}, src ? ./ ./. }:

pkgs.stdenv.mkDerivation rec {
  pname = "hello-world-rust";
  version = "0.1.0";

  inherit src;

  buildInputs = with pkgs; [
    rustc
    cargo
  ];

  buildPhase = ''
    export HOME=$(mktemp -d)
    cargo build --release --target-dir $out/target
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp $out/target/release/hello-world-rust $out/bin/hello-world-rust
  '';

  meta = with pkgs.lib; {
    description = "A simple Rust 'Hello World' program as a Nix derivation.";
    homepage = "https://example.com/hello-world-rust";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
