{ pkgs, geminiCli }:

pkgs.stdenv.mkDerivation {
  pname = "gemini-interaction";
  version = "0.1.0";

  # The geminiCli package (which is the gemini-cli derivation)
  buildInputs = [ geminiCli ];

  # The prompt to feed to Gemini
  prompt = "What is the capital of France?"; # This will be passed as an argument

  # The actual interaction
  buildCommand = ''
    # Ensure the output directory exists
    mkdir -p $out/

    # Run gemini with the prompt and save the output
    # We use 'echo "$prompt" | gemini' to feed the prompt non-interactively
    # The output is saved to a file named 'response.txt'
    echo "$prompt" | ${geminiCli}/bin/gemini > $out/response.txt
  '';

  # The output of this derivation will be a directory containing response.txt
  # We don't need to install anything, as the buildCommand already places the output in $out
  dontInstall = true;
}