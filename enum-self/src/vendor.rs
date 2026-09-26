// This module defines enums related to vendored or external dependencies.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Vendor {
    Ebpf(VendorEbpf),
    External(VendorExternal),
    Guix(VendorGuix),
    LangC(VendorLangC),
    MkAiDerivation(VendorMkAiDerivation),
    Nix(VendorNix),
    NixOnDroid(VendorNixOnDroid),
    Nixpkgs(VendorNixpkgs),
    PlantumlStdlib(VendorPlantumlStdlib),
    RnixParser(VendorRnixParser),
    RustIndexGuix(VendorRustIndexGuix),
    Steel(VendorSteel),
    Strace(VendorStrace),
}

/// Represents eBPF-related vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorEbpf {
    Aya,
    Ayaoo,
    Bpfjit,
    Bpfman,
    CleanDnsBpf,
    Eadb,
    Ebpfguard,
    LibbpfRs,
    Rbpf,
}

/// Represents external vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorExternal {
    AmazonQDeveloperCli,
    Asciinema,
    AsciinemaScenario,
    BitchatSolanaZosSolfunmeme,
    Bootstrap,
    BootstrapMeme,
    CoccinelleforrustPersonalMirror,
    EmojisRs,
    ForgejoPython,
    GeminiCli,
    GithubIssuesExportRs,
    GrokCli,
    HuggingFaceDatasetValidatorRust,
    IntrospectorLlc,
    MetaMeme,
    MinizincIntrospector,
    MonomcpRust,
    N00b,
    NixAsciinemaAgg,
    Ragit,
    Rust,
    SolfunmemeBanner,
    SolfunmemeDioxus,
    SolfunmemeMetameme,
    SolfunmemeModelBuilderQuiz,
    SophiaRs,
    Tclifford,
    Tmux,
    TmuxInterfaceRs,
    Trident,
    Turbomcp,
}

/// Represents Guix-related vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorGuix {
    Guix,
    Mes,
}

/// Represents C language-related vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorLangC {
    GitHub,
    Reftests,
    Src,
    Gitignore,
    CargoToml,
    GrammarHeader,
    GrammarRustfmt,
    GrammarRustpeg,
    LicenseApache,
    LicenseMit,
    Makefile,
    Readme,
}

/// Represents mkAIDerivation vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorMkAiDerivation {
    Vscode,
    Nix,
    Server,
    Gitignore,
    DefaultNix,
    FlakeLock,
    FlakeNix,
    License,
    Readme,
    ShellNix,
}

/// Represents Nix-related vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorNix {
    Nix,
    NixpkgsLint,
    Nixtract,
}

/// Represents Nix-on-Droid vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorNixOnDroid {
    GitHub,
    Docs,
    Modules,
    NixOnDroid,
    Overlays,
    Pkgs,
    Scripts,
    Templates,
    Tests,
    Editorconfig,
    Gitignore,
    Authors,
    ChangelogMd,
    DefaultNix,
    FlakeLock,
    FlakeNix,
    License,
    Readme,
}

/// Represents Nixpkgs vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorNixpkgs {
    Devcontainer,
    GitHub,
    Ci,
    Doc,
    Lib,
    Maintainers,
    Modules,
    Nixos,
    Pkgs,
    Editorconfig,
    GitBlameIgnoreRevs,
    Gitattributes,
    Gitignore,
    Mailmap,
    Version,
    ContributingMd,
    Copying,
    DefaultNix,
    FlakeNix,
    Readme,
    ShellNix,
}

/// Represents PlantUML standard library vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorPlantumlStdlib {
    C4PlantUml,
}

/// Represents rnix-parser vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorRnixParser {
    GitHub,
    Benches,
    Examples,
    Fuzz,
    Src,
    TestData,
    Envrc,
    Gitignore,
    CargoLock,
    CargoToml,
    ChangelogMd,
    DefaultNix,
    FlakeLock,
    FlakeNix,
    License,
    Readme,
    RustfmtToml,
    ShellNix,
}

/// Represents rust-index-guix vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorRustIndexGuix {
    Src,
    CargoVcsInfoJson,
    Gitignore,
    CargoToml,
    CargoTomlOrig,
    License,
    Readme,
    UpdateSh,
}

/// Represents Steel (Scheme dialect) vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorSteel {
    Cargo,
    GitHub,
    Benchmarks,
    Cogs,
    Contrib,
    Core,
    Crates,
    Docs,
    Examples,
    Images,
    Libs,
    Nix,
    R7rsBenchmarks,
    SelfHosted,
    Src,
    SteelExamples,
    Dockerignore,
    Envrc,
    Gitignore,
    BuildRs,
    CargoLock,
    CargoToml,
    ContributingMd,
    DefaultNix,
    DistWorkspaceToml,
    Dockerfile,
    FlakeLock,
    FlakeNix,
    LicenseApache,
    LicenseMit,
    ProfilerScm,
    Readme,
    RustfmtToml,
    ShellNix,
}

/// Represents strace-related vendor components.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum VendorStrace {
    DutchcodersTrace,
    Intrace,
    Lurk,
    Rstrace,
}