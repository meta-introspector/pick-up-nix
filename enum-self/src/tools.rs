// This module defines enums related to various tools and utilities within the project.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Tools {
    IfCounter(IfCounter),
    SocialMedia(SocialMedia),
    BatchTaskProcessor,
}

/// Represents components of the `if-counter` tool.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum IfCounter {
    Src,
    CargoToml,
}

/// Represents components of the `social_media` tool.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SocialMedia {
    MyInsightTweet,
    SocialMediaFiberLog,
    TweetTool,
    TweetConfirmation,
}