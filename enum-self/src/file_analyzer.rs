// This module defines enums related to the file analyzer tool.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum FileAnalyzer {
    Src(FileAnalyzerSrc),
    CargoToml,
}

/// Represents source files for the file analyzer.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum FileAnalyzerSrc {
    MainRs,
}