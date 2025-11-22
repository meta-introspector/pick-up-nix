

{
  description = "Simple dev shell with SSH and Git";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs";
        nixpkgs.url = "github:meta-introspector/nixpkgs?ref=feature/CRQ-016-nixify";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          git
          openssh
        ];
      };
    };
}
