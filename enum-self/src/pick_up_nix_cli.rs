// This module defines enums related to the `pick-up-nix-cli` tool.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum PickUpNixCli {
    Src(PickUpNixCliSrc),
    CargoToml,
}

/// Represents source files for the `pick-up-nix-cli` tool.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum PickUpNixCliSrc {
    Events(PickUpNixCliSrcEvents),
    Generator(PickUpNixCliSrcGenerator),
    MainRs,
}

/// Represents event-related source files for `pick-up-nix-cli`.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum PickUpNixCliSrcEvents {
    ModRs,
}

/// Represents generator-related source files for `pick-up-nix-cli`.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum PickUpNixCliSrcGenerator {
    ModRs,
}