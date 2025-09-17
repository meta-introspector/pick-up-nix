// This module defines enums related to various Nix configurations.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixConfig {
    Android,
    Base,
    Emacs,
    Scientific,
    Default,
}