// This module defines enums related to experimental projects or tools.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Experiments {
    GitSubmoduleToolsRs(GitSubmoduleToolsRs),
}

/// Represents components of the `git-submodule-tools-rs` experiment.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum GitSubmoduleToolsRs {
    FlakeNix,
}