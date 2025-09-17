// This module defines enums related to collections of tasks or task examples.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Tasks {
    HelloWorldRust(TasksHelloWorldRust),
}

/// Represents components of the `hello-world-rust` task example.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum TasksHelloWorldRust {
    Src(TasksHelloWorldRustSrc),
    CargoToml,
    DefaultNix,
}

/// Represents source files for the `hello-world-rust` task example.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum TasksHelloWorldRustSrc {
    MainRs,
}