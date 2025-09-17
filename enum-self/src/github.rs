// This module defines enums related to GitHub configurations and workflows.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum GitHub {
    Actions(GitHubActions),
    Workflows(GitHubWorkflows),
    ChangelogConfigurationJson,
    DependabotYml,
    PullRequestTemplate,
}

/// Represents GitHub Actions configurations.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum GitHubActions {
    Cache,
    CacheNixAction,
    Checkout,
    InstallNixAction,
    NixGithubActions,
    NixInstallerAction,
    UploadArtifact,
}

/// Represents GitHub Workflows.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum GitHubWorkflows {
    Build,
}