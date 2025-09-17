// This module defines enums related to the main source directory of the project.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Src {
    MainRs,
}