# `user-facing.nix` - Rust Package Set Definition

This Nix expression provides a user-facing interface for defining and configuring Rust package sets within a Nix environment, utilizing the `rustBuilder` to ensure reproducible and customizable builds. It simplifies the integration of Rust projects with Nix, particularly concerning toolchain management and `cargo2nix` setup.

## Key Features

*   **Flexible Rust Toolchain Selection:**
    *   Allows specification of `rustChannel` (e.g., "stable", "nightly") and `rustVersion`.
    *   Supports `rustProfile` (e.g., "minimal").
    *   Enables the inclusion of `extraRustComponents` (e.g., "rust-src").
    *   Can use an explicitly provided `rustToolchain` or construct one based on the channel, version, and profile.
    *   Includes logic to handle legacy `rustChannel` values that might contain a version string.

*   **Target Platform Configuration:**
    *   Determines `targetInfo` based on `stdenv.hostPlatform` or an explicit `targetSpecFile`/`targetSpec`.
    *   Allows specifying a `target` for cross-compilation.

*   **`cargo2nix` Integration:**
    *   Integrates `cargo2nix` as a runtime dependency, ensuring it is correctly wrapped with the appropriate `PATH` to locate the selected `rustToolchain`. This minimizes flake noise and guarantees `cargo2nix` can find `rustc`.

*   **Package Overrides:**
    *   Provides a mechanism for `packageOverrides` to customize packages within the set.
    *   Applies a specific override for `cargo2nix` to ensure its proper functioning within the Nix environment.

*   **Internal `makePackageSetInternal` Call:**
    *   Ultimately invokes `rustBuilder.makePackageSetInternal` to evaluate the Rust package set, passing all configured arguments.
    *   Manages `buildRustPackages` by making an additional `makePackageSetInternal` call with a `null` target, typically for host-platform builds.

## Arguments (`args`)

The following arguments can be passed to this Nix expression:

*   `packageFun`: (Required) A function that defines how to build the Rust packages.
*   `rustChannel`: (Optional) The Rust release channel (e.g., "stable", "nightly"). Defaults to "stable" if not specified.
*   `rustVersion`: (Optional) The specific Rust version.
*   `rustToolchain`: (Optional) An explicit Rust toolchain to use. If provided, `rustChannel` and `rustVersion` are ignored for toolchain selection.
*   `rustProfile`: (Optional) The Rust toolchain profile (e.g., "minimal"). Defaults to "minimal".
*   `extraRustComponents`: (Optional) A list of extra Rust components to include (e.g., `[ "rust-src" ]`).
*   `packageOverrides`: (Optional) A function that takes `pkgs` and returns a list of package overrides. Defaults to `pkgs: pkgs.rustBuilder.overrides.all`.
*   `target`: (Optional) The target platform for cross-compilation.
*   `workspaceSrc`: (Optional) The source directory of the Rust workspace.
*   `ignoreLockHash`: (Optional) Boolean to ignore the lock hash.
*   `targetSpecFile`: (Optional) Path to a JSON file specifying target information.
*   `targetSpec`: (Optional) A JSON object directly specifying target information.
*   `cargoConfig`: (Optional) Configuration for Cargo.

## Purpose

This file serves as a foundational component for users to define and configure their Rust projects within a Nix environment. It leverages `rustBuilder` to create reproducible and customizable Rust package sets, abstracting away complexities related to Nix and Rust integration, especially concerning toolchain management and `cargo2nix` setup.
