// This file defines the top-level `ProjectAspect` enum and its sub-enums,
// which categorize different aspects of the project's structure at a higher level.

use crate::project_items::project_item::{ConfigurationAndEnvironment, CodeAndDevelopment, DocumentationAndMetadata, VersionControlAndBuildSystems, ProjectManagement, ExternalVendor, TopLevelFile};

/// Represents a high-level aspect or domain within the project.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ProjectAspect {
    CoreProjectElements(CoreProjectElements),
    SupportingElements(SupportingElements),
}

/// Groups core elements essential for the project's primary function.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum CoreProjectElements {
    ConfigurationAndEnvironment(ConfigurationAndEnvironment),
    CodeAndDevelopment(CodeAndDevelopment),
    VersionControlAndBuildSystems(VersionControlAndBuildSystems),
    ProjectManagement(ProjectManagement),
}

/// Groups supporting elements that facilitate the project's operation and documentation.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum SupportingElements {
    DocumentationAndMetadata(DocumentationAndMetadata),
    ExternalVendor(ExternalVendor),
    TopLevelFile(TopLevelFile),
}
