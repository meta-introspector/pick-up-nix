// This module defines enums related to various packages within the project.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Packages {
    GeminiCli(GeminiCli),
    GeminiInteraction(GeminiInteraction),
}

/// Represents components of the `gemini-cli` package.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum GeminiCli {
    DefaultNix,
    FlakeNix,
}

/// Represents components of the `gemini-interaction` package.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum GeminiInteraction {
    DefaultNix,
}