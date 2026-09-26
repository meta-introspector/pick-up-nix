// This module defines enums related to the JSON to memes extractor tool.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum JsonToMemesExtractor {
    Src(JsonToMemesExtractorSrc),
    CargoToml,
}

/// Represents source files for the JSON to memes extractor.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum JsonToMemesExtractorSrc {
    MainRs,
}