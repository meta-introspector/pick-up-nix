#!/usr/bin/env bash
#git push git+ssh://ubuntu@129.213.85.94:/var/git/pick-up-nix/

#sudo mkdir -p /var/git/cargo2nix/
#sudo chown ubuntu: -R /var/git/
#rm -rf /var/git/
#sudo git init --bare /var/git/pick-up-nix/
pushd /var/pick-up-nix/vendor/nix/
#rm -rf cargo2nix/
#git remote add local /var/git/pick-up-nix/
#git config --global --add safe.directory /var/git/pick-up-nix
git pull local feature/CRQ-016-nixify

#git rebase --abort
#git reset --hard
#git checkout local/feature/CRQ-016-nixify --force
git status
git submodule foreach git status 
#git submodule update --init --recursive
#bash -x ./run_nested2.sh
#popd
# 
#bash ./run_emacs.sh
