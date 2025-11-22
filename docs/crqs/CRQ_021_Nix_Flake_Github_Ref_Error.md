# CRQ: Nix Flake GitHub Reference Error

**Date:** October 17, 2025

**Description:**
When attempting to build the `xpy-json-output-flake`, a GitHub reference error occurred, indicating that a specified branch could not be found.

**Command Executed:**
```
nix build ./vendor/rust/rust-bootstrap-nix/flakes/xpy-json-output-flake
```

**Error Output:**
```
warning: Git tree '/data/data/com.termux.nix/files/home/pick-up-nix2/vendor/rust/platform-tools-agave-rust-solana/vendor/rust-src/vendor/rust/rust-bootstrap-nix' is dirty
error:
       … while updating the lock file of flake 'git+file:///data/data/com.termux.nix/files/home/pick-up-nix2/vendor/rust/platform-tools-agave-rust-solana/vendor/rust-src/vendor/rust/rust-bootstrap-nix?dir=flakes/xpy-json-output-flake'

       … while updating the flake input 'nixJsonOutputRoot'

       … while fetching the input 'github:meta-introspector/platform-tools-agave-rust-solana/feature/lattice-30030-homedir'

       error: unable to download 'https://api.github.com/repos/meta-introspector/platform-tools-agave-rust-solana/commits/feature/lattice-30030-homedir': HTTP error 422

       response body:

       {
         "message": "No commit found for SHA: feature/lattice-30030-homedir",
         "documentation_url": "https://docs.github.com/rest/commits/commits#get-a-commit",
         "status": "422"
       }
```

**Root Cause (Initial Assessment):**
The `ref` parameter in the GitHub URL for `nixJsonOutputRoot` (`feature/lattice-30030-homedir`) does not correspond to an existing branch or commit in the `meta-introspector/platform-tools-agave-rust-solana` repository.

**Proposed Resolution:**
Verify the correct branch name for the `platform-tools-agave-rust-solana` repository and update the `ref` in the `flake.nix` accordingly. Alternatively, if `nixJsonOutputRoot` is meant to be the output of a job, the flake definition needs to be adjusted to reflect that.
