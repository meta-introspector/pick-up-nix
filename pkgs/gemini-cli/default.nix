{ pkgs, nodejs, geminiCliSrc }:

pkgs.stdenv.mkDerivation {
  pname = "gemini-cli";
  version = "0.3.4"; # Match the version from package.json

  src = geminiCliSrc;

  nativeBuildInputs = [ nodejs pkgs.which ];

  installPhase = ''
    npm install
    npm run bundle
    mkdir -p $out/bin
    cp bundle/gemini.js $out/bin/gemini
  '';
}