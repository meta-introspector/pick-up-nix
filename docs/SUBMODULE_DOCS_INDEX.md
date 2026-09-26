# Submodule Documentation Index

## .github/actions/cache
### /data/data/com.termux.nix/files/home/pick-up-nix/.github/actions/cache/README.md
```
# Cache action

This action allows caching dependencies and build outputs to improve workflow execution time.

>Two other actions are available in addition to the primary `cache` action:
>* [Restore action](./restore/README.md)
>* [Save action](./save/README.md)

[![Tests](https://github.com/actions/cache/actions/workflows/workflow.yml/badge.svg)](https://github.com/actions/cache/actions/workflows/workflow.yml)
```

## .github/actions/cache-nix-action
### /data/data/com.termux.nix/files/home/pick-up-nix/.github/actions/cache-nix-action/README.md
```
# Cache Nix Store

A GitHub Action to restore and save Nix store paths using GitHub Actions cache.

This action is based on [actions/cache](https://github.com/actions/cache).

## Additional actions

- [Restore action](./restore/README.md)
- [Save action](./save/README.md)
```

## .github/actions/checkout
### /data/data/com.termux.nix/files/home/pick-up-nix/.github/actions/checkout/README.md
```
[![Build and Test](https://github.com/actions/checkout/actions/workflows/test.yml/badge.svg)](https://github.com/actions/checkout/actions/workflows/test.yml)

# Checkout V4

This action checks-out your repository under `$GITHUB_WORKSPACE`, so your workflow can access it.

Only a single commit is fetched by default, for the ref/SHA that triggered the workflow. Set `fetch-depth: 0` to fetch all history for all branches and tags. Refer [here](https://docs.github.com/actions/using-workflows/events-that-trigger-workflows) to learn which commit `$GITHUB_SHA` points to for different events.

The auth token is persisted in the local git config. This enables your scripts to run authenticated git commands. The token is removed during post-job cleanup. Set `persist-credentials: false` to opt-out.
```

## .github/actions/install-nix-action
### /data/data/com.termux.nix/files/home/pick-up-nix/.github/actions/install-nix-action/README.md
```
# install-nix-action

![GitHub Actions badge](https://github.com/cachix/install-nix-action/workflows/install-nix-action%20test/badge.svg)

Installs [Nix](https://nixos.org/nix/) on GitHub Actions runners for Linux and macOS.

# Features

- Quick installation (~4s on Linux / ~20s on macOS)
- Multi-user installation with sandboxing enabled by default on Linux
```

## .github/actions/nix-github-actions
### /data/data/com.termux.nix/files/home/pick-up-nix/.github/actions/nix-github-actions/README.md
```
# nix-github-actions
This is a library to turn Nix Flake attribute sets into Github Actions matrices.

**Features:**

- Unopinionated

Install Nix using any method you like

- Flexible
```

## .github/actions/nix-installer-action
### /data/data/com.termux.nix/files/home/pick-up-nix/.github/actions/nix-installer-action/README.md
```
# The Determinate Nix Installer Action

Based on the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer), responsible for over tens of thousands of Nix installs daily.
The fast, friendly, and reliable GitHub Action to install Nix with Flakes.

## Supports

- ✅ **Accelerated KVM** on open source projects and larger runners. See [GitHub's announcement](https://github.blog/changelog/2023-02-23-hardware-accelerated-android-virtualization-on-actions-windows-and-linux-larger-hosted-runners/) for more info.
- ✅ Linux, x86_64, aarch64, and i686
- ✅ macOS, x86_64 and aarch64
```

## .github/actions/upload-artifact
### /data/data/com.termux.nix/files/home/pick-up-nix/.github/actions/upload-artifact/README.md
```
# `@actions/upload-artifact`

Upload [Actions Artifacts](https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts) from your Workflow Runs. Internally powered by [@actions/artifact](https://github.com/actions/toolkit/tree/main/packages/artifact) package.

See also [download-artifact](https://docs.github.com/en/actions/download-artifact).

- [`@actions/upload-artifact`](#actionsupload-artifact)
  - [v4 - What's new](#v4---whats-new)
    - [Improvements](#improvements)
    - [Breaking Changes](#breaking-changes)
```
### /data/data/com.termux.nix/files/home/pick-up-nix/.github/actions/upload-artifact/docs/MIGRATION.md
```
# Migration

- [Migration](#migration)
  - [Multiple uploads to the same named Artifact](#multiple-uploads-to-the-same-named-artifact)
  - [Overwriting an Artifact](#overwriting-an-artifact)
  - [Merging multiple artifacts](#merging-multiple-artifacts)

Several behavioral differences exist between Artifact actions `v3` and below vs `v4`. This document outlines common scenarios in `v3`, and how they would be handled in `v4`.

## Multiple uploads to the same named Artifact
```

## nixpacks
### /data/data/com.termux.nix/files/home/pick-up-nix/nixpacks/README.md
```
# Nixpacks

[![CI](https://github.com/railwayapp/nixpacks/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/railwayapp/nixpacks/actions/workflows/ci.yml)
[![Crates.io](https://img.shields.io/crates/v/nixpacks)](https://crates.io/crates/nixpacks)
[![Rust: 1.70+](https://img.shields.io/badge/rust-1.70+-93450a)](https://blog.rust-lang.org/2023/06/01/Rust-1.70.0.html)

**App source + Nix packages + Docker = Image**

Nixpacks takes a source directory and produces an OCI compliant image that can be deployed anywhere. The project was started by the [Railway](https://railway.app) team as an alternative to [Buildpacks](https://buildpacks.io/) and attempts to address a lot of the shortcomings and issues that occurred when deploying thousands of user apps to the Railway platform. The biggest change is that system and language dependencies are pulled from the Nix ecosystem.
```
### /data/data/com.termux.nix/files/home/pick-up-nix/nixpacks/docs/pages/docs/getting-started.md
```
---
title: Getting Started
---

# {% $markdoc.frontmatter.title %}

To get started with Nixpacks you need an app that you want to build and package. You can bring your own or use one of the [many examples on GitHub](https://github.com/railwayapp/nixpacks/tree/main/examples).

## 1. Install
```
### /data/data/com.termux.nix/files/home/pick-up-nix/nixpacks/docs/pages/docs/cli.md
```
---
title: CLI
---

# {% $markdoc.frontmatter.title %}

The main Nixpacks commands are `build` and `plan`.

## Build
```

## source/github/jmikedupont2/orgs/Escaped-RDFa/namespace
### /data/data/com.termux.nix/files/home/pick-up-nix/source/github/jmikedupont2/orgs/Escaped-RDFa/namespace/README.md
```
# Escaped-RDFa/namespace

This repository contains the source code for the Escaped-RDFa namespace.
```

## source/github/meta-introspector/git-submodule-tools-rs
### /data/data/com.termux.nix/files/home/pick-up-nix/source/github/meta-introspector/git-submodule-tools-rs/README.md
```
# git-submodule-tools-rs

A collection of tools for managing Git submodules, written in Rust.
```

## source/github/meta-introspector/lean4
### /data/data/com.termux.nix/files/home/pick-up-nix/source/github/meta-introspector/lean4/README.md
```
# Lean 4

This is the Lean 4 theorem prover.
```

## source/github/meta-introspector/solfunmeme
### /data/data/com.termux.nix/files/home/pick-up-nix/source/github/meta-introspector/solfunmeme/README.md
```
# solfunmeme

A collection of Solana-related fun memes.
```

## source/github/meta-introspector/streamofrandom
### /data/data/com.termux.nix/files/home/pick-up-nix/source/github/meta-introspector/streamofrandom/README.md
```
# streamofrandom

A Rust library for generating a stream of random numbers.
```

## vendor/external/aichat
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/aichat/README.md
```
# aichat

A simple AI chat application.
```

## vendor/external/amazon-q-developer-cli
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/amazon-q-developer-cli/README.md
```
# Amazon Q Developer CLI

The Amazon Q Developer CLI is a command-line interface for interacting with Amazon Q Developer.
```

## vendor/external/bitchat-solana-zos-solfunmeme
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/bitchat-solana-zos-solfunmeme/README.md
```
# bitchat-solana-zos-solfunmeme

A Solana-based chat application with ZOS integration and solfunmeme features.
```

## vendor/external/bootstrap
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/bootstrap/README.md
```
# Bootstrap

The most popular HTML, CSS, and JS library in the world.
```

## vendor/external/bootstrap-meme
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/bootstrap-meme/README.md
```
# bootstrap-meme

A meme-themed Bootstrap customization.
```

## vendor/external/coccinelleforrust_personal_mirror
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/coccinelleforrust_personal_mirror/README.md
```
# coccinelleforrust_personal_mirror

A personal mirror of Coccinelle for Rust.
```

## vendor/external/emojis-rs
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/emojis-rs/README.md
```
# emojis-rs

A Rust library for working with emojis.
```

## vendor/external/forgejo-python
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/forgejo-python/README.md
```
# forgejo-python

A Python client for Forgejo.
```

## vendor/external/grok-cli
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/grok-cli/README.md
```
# grok-cli

A command-line interface for Grok.
```

## vendor/external/hugging-face-dataset-validator-rust
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/hugging-face-dataset-validator-rust/README.md
```
# hugging-face-dataset-validator-rust

A Rust library for validating Hugging Face datasets.
```

## vendor/external/introspector-llc
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/introspector-llc/README.md
```
# introspector-llc

Introspector LLC website and tools.
```

## vendor/external/lattice-introspector
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/lattice-introspector/README.md
```
# lattice-introspector

A tool for introspecting lattice structures.
```

## vendor/external/meta-meme
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/meta-meme/README.md
```
# meta-meme

A framework for creating meta-memes.
```

## vendor/external/minizinc-introspector
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/minizinc-introspector/README.md
```
# minizinc-introspector

A tool for introspecting MiniZinc models.
```

## vendor/external/monomcp-rust
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/monomcp-rust/README.md
```
# monomcp-rust

A Rust implementation of the MonoMCP protocol.
```

## vendor/external/n00b
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/n00b/README.md
```
# n00b

A simple command-line tool for beginners.
```

## vendor/external/ragit
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/ragit/README.md
```
# ragit

A Git client written in Rust.
```

## vendor/external/solfunmeme-banner
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/solfunmeme-banner/README.md
```
# solfunmeme-banner

A banner for solfunmeme.
```

## vendor/external/solfunmeme-dioxus
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/solfunmeme-dioxus/README.md
```
# solfunmeme-dioxus

A Dioxus-based frontend for solfunmeme.
```

## vendor/external/solfunmeme-metameme
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/solfunmeme-metameme/README.md
```
# solfunmeme-metameme

A meta-meme for solfunmeme.
```

## vendor/external/solfunmeme-model-builder-quiz
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/solfunmeme-model-builder-quiz/README.md
```
# solfunmeme-model-builder-quiz

A quiz for building solfunmeme models.
```

## vendor/external/sophia_rs
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/sophia_rs/README.md
```
# sophia_rs

A Rust library for working with RDF.
```

## vendor/external/tclifford
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/tclifford/README.md
```
# tclifford

A Rust library for Clifford algebra.
```

## vendor/external/tmux
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/tmux/README.md
```
# tmux

A terminal multiplexer.
```

## vendor/external/tmux-interface-rs
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/tmux-interface-rs/README.md
```
# tmux-interface-rs

A Rust interface for tmux.
```

## vendor/external/trident
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/trident/README.md
```
# trident

A Rust library for working with Trident.
```

## vendor/external/turbomcp
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/external/turbomcp/README.md
```
# turbomcp

A fast Rust implementation of the MonoMCP protocol.
```

## vendor/nix-on-droid
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/nix-on-droid/README.md
```
# nix-on-droid

Nix on Android.
```

## vendor/quasi-meta-meme
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/quasi-meta-meme/README.md
```
# quasi-meta-meme

A quasi-meta-meme.
```

## vendor/rnix-parser
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/rnix-parser/README.md
```
# rnix-parser

A Nix parser written in Rust.
```

## vendor/rust-index-guix
### /data/data/com.termux.nix/files/home/pick-up-nix/vendor/rust-index-guix/README.md
```
# rust-index-guix

A Guix package for Rust.
```
