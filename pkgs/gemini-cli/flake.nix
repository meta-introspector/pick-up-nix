{
  description = "A flake for the gemini-cli package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; # Pin to a stable NixOS release
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; # Assuming x86_64-linux, adjust if needed
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.nodejs_22 ];
        # You can add other development tools here if needed
      };

      packages.${system}.default = pkgs.callPackage ./default.nix {
        nodejs = pkgs.nodejs_22; # Pass the specific nodejs version to default.nix
      };
    };
}