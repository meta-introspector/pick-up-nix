// This file defines the top-level `ProjectItem` enum and its sub-enums,
// which categorize different aspects of the project's structure.

use crate::{
    config, configurations, documentation, enum_self, etc, experiments, file_analyzer, github, home,
    json_to_memes_extractor, logs, manifests, memetic_code, new, nixpacks, packages,
    pick_up_nix_cli, prompts, qa, source, src_dir, submodule_flakes, task, tasks, test_flake,
    tools, vendor, wrappers,
};

/// Represents a top-level item or category within the project structure.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ProjectItem {
    ConfigurationAndEnvironment(ConfigurationAndEnvironment),
    CodeAndDevelopment(CodeAndDevelopment),
    DocumentationAndMetadata(DocumentationAndMetadata),
    VersionControlAndBuildSystems(VersionControlAndBuildSystems),
    ProjectManagement(ProjectManagement),
    ExternalVendor(ExternalVendor),
    TopLevelFile(TopLevelFile),
    Wrapped(wrappers::WrappedItem),
}

/// Categorizes configuration and environment-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ConfigurationAndEnvironment {
    Config(crate::config::Config),
    NixDefexpr,
    Configurations(crate::configurations::Configurations),
    Home(crate::home::Home),
    New(crate::new::New),
    Etc(crate::etc::Etc),
}

/// Categorizes code and development-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum CodeAndDevelopment {
    EnumSelf(crate::enum_self::EnumSelf),
    FileAnalyzer(crate::file_analyzer::FileAnalyzer),
    JsonToMemesExtractor(crate::json_to_memes_extractor::JsonToMemesExtractor),
    MemeticCode(crate::memetic_code::MemeticCode),
    PickUpNixCli(crate::pick_up_nix_cli::PickUpNixCli),
    Pkgs(crate::packages::Packages),
    Src(crate::src_dir::Src),
    Tools(crate::tools::Tools),
    Experiments(crate::experiments::Experiments),
}

/// Categorizes documentation and metadata-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum DocumentationAndMetadata {
    Docs(crate::documentation::Documentation),
    Logs(crate::logs::Logs),
    Manifests(crate::manifests::Manifests),
    Prompts(crate::prompts::Prompts),
    Qa(crate::qa::Qa),
}

/// Categorizes version control and build system-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VersionControlAndBuildSystems {
    GitHub(crate::github::GitHub),
    SubmoduleFlakes(crate::submodule_flakes::SubmoduleFlakes),
    Nixpacks(crate::nixpacks::Nixpacks),
}

/// Categorizes project management-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ProjectManagement {
    Task(crate::task::Task),
    Tasks(crate::tasks::Tasks),
}

/// Categorizes external and vendor-provided components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ExternalVendor {
    Vendor(crate::vendor::Vendor),
}

/// Represents various top-level files in the project root.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum TopLevelFile {
    CargoToml,
    CargoLock,
    FlakeNix,
    FlakeLock,
    TodoHelperSh,
    AspellEnPrepl,
    AspellEnPws,
    Envrc,
    Gitignore,
    Gitmodules,
    NixChannels,
    ArchitecturalVisionMd,
    BootSh,
    BuildAndReportSh,
    BuildOutputCargoMetadataLog,
    BuildOutputGitoxideLog,
    BuildOutputMetaMemeLog,
    BuildOutputMetaMemeWikiLog,
    BuildOutputOctocrabLog,
    BuildOutputZolaLog,
    BuildQaProcessSh,
    ChunkFilesPy,
    CommitAllChangesSh,
    DwimSh,
    EnterAndRunTracenixSh,
    ExtractStracePathsSh,
    FilesTxt,
    FixSubmodulesSh,
    GeminiCliEntrypointSh,
    GeminiCliRecentSh,
    GeminiCliSh,
    GeminiSplitSh,
    GeminiMd,
    GenerateNixGraphSh,
    GettargetsSh,
    IdeasMd,
    InspectNixEnvStackSh,
    InstallNagiosSh,
    InstallService2Sh,
    InstallService3Sh,
    IntegrityVerificationCrqMd,
    ListStracePathsSh,
    MemesMd,
    MinizincEmojiPrimesMzn,
    NotesOrg,
    PetalsSh,
    PoemTweetTxt,
    PoetryTaskMd,
    ProjectProcessMd,
    ReadmeMd,
    ReconstructNestedEnvSh,
    ReconstructionNix,
    RunBootSh,
    RunLogProcessorSh,
    RunTracenixVerboseSh,
    RuntestsSh,
    RustNixEntrypointSh,
    RustMd,
    SetupDirenvSh,
    ShellNix,
    ShellSh,
    SingleGeminiSplitSh,
    StartQaBuildSh,
    StatusTxt,
    SubmoduleCheckoutLogMd,
    SubmoduleIssuesTxt,
    SubtaskSh,
    TaskMd,
    TestProvisionalFlakesSh,
    TestReconstructionEnvSh,
    TestTracenixSh,
    TestSh,
    Test2Sh,
    TodoSh,
    ToolEvaluationSopMd,
    UpdateIndexSh,
    UpdateSubmoduleFlakesSh,
    UpdateSubmoduleShasSh,
}