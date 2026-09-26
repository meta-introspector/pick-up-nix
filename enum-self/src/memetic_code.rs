// This module defines enums related to memetic code components.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum MemeticCode {
    EmojiLlmMachineRust(EmojiLlmMachineRust),
    LogProcessor(LogProcessor),
    EmojiLlmMachinePy,
}

/// Represents components of the `emoji_llm_machine_rust`.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum EmojiLlmMachineRust {
    Src,
    CargoToml,
}

/// Represents components of the `log_processor`.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum LogProcessor {
    Src,
    CargoToml,
    ConfigToml,
}