#!/usr/bin/env bash

set -x
echo "Entering first nix develop shell (from dev1.sh) and then nesting another nix develop to run doit.sh..."
nix develop ~/pick-up-nix2/ -c ./run_doit.sh

echo "Script finished."
