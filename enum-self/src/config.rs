// This module defines enums related to project configuration files.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Config {
    HomeManager(ConfigHomeManager),
    Nix(ConfigNix),
    DefaultNix,
}

/// Represents configuration files specific to Home Manager.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ConfigHomeManager {
    HomeNix,
}

/// Represents configuration files specific to Nix.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ConfigNix {
    ConfigurationNix,
    DefaultNix,
    NixConf,
}