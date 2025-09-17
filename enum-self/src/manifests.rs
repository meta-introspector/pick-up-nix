// This module defines enums related to manifest files.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Manifests {
    ProvisionalFlakeFilesJson,
}