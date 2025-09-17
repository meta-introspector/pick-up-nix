// This module defines enums related to Quality Assurance (QA) scripts and configurations.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Qa {
    NixBuildsSh,
    NixLintersSh,
}