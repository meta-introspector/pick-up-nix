// This module defines enums related to individual tasks or task configurations.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Task {
    Ainix(TaskAinix),
}

/// Represents components of the `ainix` task.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum TaskAinix {
    Logs(TaskAinixLogs),
    AddMkaiderivationSubmoduleLog,
    AddMkaiderivationSubmoduleSh,
    SopAddMkaiderivationSubmoduleMd,
    SopUpdateSubmodulesMd,
    UpdateAllSubmodulesLog,
    UpdateAllSubmodulesSh,
}

/// Represents log files for the `ainix` task.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum TaskAinixLogs {
    AddMkaiderivationSubmoduleStraceLog,
    AddMkaiderivationSubmoduleLog,
    UpdateAllSubmodulesStraceLog,
    UpdateAllSubmodulesLog,
}