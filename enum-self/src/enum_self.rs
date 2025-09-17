// This module defines enums for the `enum-self` crate itself.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum EnumSelf {
    Src(EnumSelfSrc),
    CargoLock,
    CargoToml,
    DefaultNix,
    FlakeLock,
    FlakeNix,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum EnumSelfSrc {
    ProjectAspects(ProjectAspects),
    ProjectItems(ProjectItems),
    ConfigRs,
    ConfigurationsRs,
    DocumentationRs,
    EtcRs,
    ExperimentsRs,
    FileAnalyzerRs,
    GithubRs,
    HomeRs,
    JsonToMemesExtractorRs,
    LibRs(LibRs),
    LogsRs,
    MainRs,
    ManifestsRs,
    MemeticCodeRs,
    NewRs,
    NixConfigRs,
    NixpacksRs,
    PackagesRs,
    PickUpNixCliRs,
    PromptsRs,
    QaRs,
    SourceRs,
    SrcDirRs,
    SubmoduleFlakesRs,
    TaskRs,
    TasksRs,
    TestFlakeRs,
    ToolsRs,
    VendorRs,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ProjectAspects {
    ModRs,
    ProjectAspectRs,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ProjectItems {
    ModRs,
    ProjectItemRs,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum LibRs {
    Tests(TestsModule),
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum TestsModule {
    TestProjectItemSerialization,
    TestSelfDescription,
    TestDescriptionOfSelfDescriptionTest,
}