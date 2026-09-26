// This module defines enums related to Nixpacks configurations and components.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Nixpacks {
    Cargo(NixpacksCargo),
    Devcontainer(NixpacksDevcontainer),
    GitHub(NixpacksGitHub),
    Base(NixpacksBase),
    Docs(NixpacksDocs),
    Examples(NixpacksExamples),
    Src(NixpacksSrc),
    TestHelper(NixpacksTestHelper),
    Tests(NixpacksTests),
    Wix(NixpacksWix),
    Gitattributes,
    Gitignore,
    CargoLock,
    CargoToml,
    Contributing,
    FlakeLock,
    FlakeNix,
    InstallPs1,
    InstallSh,
    License,
    Makefile,
    Readme,
    ReleaseToml,
    UninstallSh,
}

/// Represents Nixpacks Cargo-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksCargo {
    ConfigToml,
}

/// Represents Nixpacks Devcontainer-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksDevcontainer {
    LibraryScripts,
    DevcontainerJson,
    Dockerfile,
}

/// Represents Nixpacks GitHub-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksGitHub {
    IssueTemplate,
    Workflows,
    ChangelogConfigurationJson,
    DependabotYml,
    PullRequestTemplate,
}

/// Represents Nixpacks Base-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksBase {
    Debian,
    Ubuntu,
}

/// Represents Nixpacks Docs-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksDocs {
    Components,
    Hooks,
    Markdoc,
    Pages,
    Public,
    Typings,
    EslintrcJson,
    Gitignore,
    Prettierignore,
    PrettierrcJs,
    ConstantsTs,
    NextEnvDTs,
    NextConfigJs,
    PackageJson,
    PostcssConfigJs,
    Readme,
    SidebarTs,
    TailwindConfigJs,
    TsconfigJson,
    YarnLock,
}

/// Represents Nixpacks Examples.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksExamples {
    AptFfmpeg,
    BasicGleam,
    Clojure,
}

/// Represents Nixpacks Source-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksSrc {
    Nixpacks,
    Providers,
    ChainRs,
    LibRs,
    MainRs,
}

/// Represents Nixpacks Test Helper components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksTestHelper {
    Src,
    CargoToml,
}

/// Represents Nixpacks Tests.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksTests {
    Snapshots,
    DockerRunTestsRs,
    GeneratePlanTestsRs,
}

/// Represents Nixpacks Wix-related components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixpacksWix {
    LicenseRtf,
    MainWxs,
}