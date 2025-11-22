#!/usr/bin/env bash

set -x

pushx /data/data/com.termux.nix/files/home/nix/vendor/rust/cargo2nix/tools/
gemini.js --output-format json \
	  --approval-mode yolo \
	  --model gemini-2.5-flash \
	  --checkpointing \
	  --include-directories=/data/data/com.termux.nix/files/home/nix/vendor/rust/cargo2nix/workspaces \
	  --include-directories=/data/data/com.termux.nix/files/home/nix/vendor/rust/cargo2nix/tools 
