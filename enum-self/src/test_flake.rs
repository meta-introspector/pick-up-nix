// This module defines enums related to the test flake.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum TestFlake {
    FlakeNix,
}