#!/usr/bin/env bash

#scp -i c2nr.sh ssh-key-2025-11-19.key ubuntu@129.213.85.94:
#ssh -i ~/ssh-key-2025-11-19.key ubuntu@129.213.85.94 "mkdir scripts"
#scp -i ~/ssh-key-2025-11-19.key *.sh ~/ssh-key-2025-11-19.key ubuntu@129.213.85.94:scripts/
#scp -i ~/ssh-key-2025-11-19.key c2nr.sh ~/ssh-key-2025-11-19.key ubuntu@129.213.85.94:scripts/
scp  c2nr.sh ~/ssh-key-2025-11-19.key ubuntu@129.213.85.94:scripts/
#scp -i ~/ssh-key-2025-11-19.key *.sh ~/ssh-key-2025-11-19.key ubuntu@129.213.85.94:/var/picl-up-nix/vendor/nix/cargo2nix/

#ssh -i ~/ssh-key-2025-11-19.key ubuntu@129.213.85.94 "bash -x scripts/c2nr.sh"
ssh ubuntu@129.213.85.94 "bash -x scripts/c2nr.sh"
