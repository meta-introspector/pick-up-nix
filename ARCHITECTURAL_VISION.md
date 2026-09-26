# Architectural Vision: On-Chain Software Supply Chain Verification

## 1.0 Core Concept

The goal of this project is to create a system for producing cryptographically verifiable digital assets that represent software components. These assets, analogous to Non-Fungible Tokens (NFTs), will provide a complete, auditable history from source code to binary execution, creating a "proof-of-integrity" and a "proof-of-execution."

Crucially, the Gödel numbering system for this project will not rely on a single, fixed number, but rather on a function that dynamically finds a suitable number, effectively preparing the arithmetization of the program for the proof system.

## 2.0 The Digital Asset ("Smart Contract")

Each version-controlled repository (e.g., a git submodule) is an instance of a "smart contract" with the following properties:

*   **Identity:** The git URL and commit hash.
*   **Metadata:** A link to its Nix derivation, which defines its dependencies and build process.
*   **Authenticity:** A GPG signature from the author/maintainer.
*   **Proof of Integrity:** The Nix NAR hash of its source code.
*   **Proof of Execution:** A verifiable audit trace of its build process.

## 3.0 The Proof Generation Pipeline

### Phase 1: Observation & Indexing
The `observe` command recursively scans all sources (local, git, etc.) and creates a structured, indexed catalog of all software components.

### Phase 2: Build & Trace (eBPF)
When a component is built using Nix, we will use **eBPF and binary instrumentation** to trace the entire execution of the build process. This trace will capture:
*   All system calls made by the compiler and build tools.
*   All file access, ensuring no undeclared dependencies are used.
*   All network access, enforcing build purity.
This captured trace serves as the **Proof of Execution**.

### Phase 3: Attestation & Signing (GPG)
The final build artifact (the binary) and its Proof of Execution trace are cryptographically hashed together. This final hash is the component's "attestation," which is then signed with the author's GPG key.

### Phase 4: Minting (Blockchain)
The GPG-signed attestation is then "minted" as a digital asset. The initial implementation will be a local registry, with the future goal of bridging these assets to public blockchains like Ethereum and Solana.

## 4.0 Advanced Concepts: Injected Runtime Probes

A future goal is to explore injecting a lightweight, user-space eBPF probe directly into the compiled binaries. This would allow the binary to produce a proof of its own execution at runtime, creating a fully self-verifying software artifact.
