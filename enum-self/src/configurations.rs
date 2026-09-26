// This module defines enums related to project configurations.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Configurations {
    AndroidNix,
}
