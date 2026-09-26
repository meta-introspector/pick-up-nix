// This module defines enums related to newly created or temporary files/directories.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum New {
    NixProfile(NewNixProfile),
}

/// Represents components within a Nix profile.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NewNixProfile {
    Bin,
    Etc,
    Include,
    Lib,
    Libexec,
    ResourceRoot,
    Sbin,
    Share,
    ManifestNix,
}