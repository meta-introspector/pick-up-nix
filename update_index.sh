#!/usr/bin/env bash
find . > data/files.txt
find . -type f -name \*.md  > data/md.txt
find . -type f -name \*.rs  > data/rs.txt
find . -type f -name \*.mnz > data/mzn.txt
grep -i Cargo.toml data/files.txt > data/rust_cargo.txt
