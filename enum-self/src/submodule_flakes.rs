// This module defines enums related to various submodule flakes.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SubmoduleFlakes {
    CargoMetadata(SubmoduleFlakesCargoMetadata),
    Gitoxide(SubmoduleFlakesGitoxide),
    MetaIntrospectorMetaMeme(SubmoduleFlakesMetaIntrospectorMetaMeme),
    MetaIntrospectorMetaMemeWiki(SubmoduleFlakesMetaIntrospectorMetaMemeWiki),
    MetaIntrospectorMkAiDerivation(SubmoduleFlakesMetaIntrospectorMkAiDerivation),
    Octocrab(SubmoduleFlakesOctocrab),
    Zola(SubmoduleFlakesZola),
}

/// Represents components of the `cargo_metadata` submodule flake.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SubmoduleFlakesCargoMetadata {
    FlakeNix,
}

/// Represents components of the `gitoxide` submodule flake.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SubmoduleFlakesGitoxide {
    FlakeNix,
}

/// Represents components of the `meta-introspector-meta-meme` submodule flake.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SubmoduleFlakesMetaIntrospectorMetaMeme {
    FlakeNix,
}

/// Represents components of the `meta-introspector-meta-meme.wiki` submodule flake.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SubmoduleFlakesMetaIntrospectorMetaMemeWiki {
    FlakeNix,
}

/// Represents components of the `meta-introspector-mkAIDerivation` submodule flake.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SubmoduleFlakesMetaIntrospectorMkAiDerivation {
    FlakeNix,
}

/// Represents components of the `octocrab` submodule flake.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SubmoduleFlakesOctocrab {
    FlakeNix,
}

/// Represents components of the `zola` submodule flake.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SubmoduleFlakesZola {
    FlakeNix,
}