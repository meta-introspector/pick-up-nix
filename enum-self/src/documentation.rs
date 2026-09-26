// This module defines enums related to project documentation.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Documentation {
    Crqs(Crqs),
    Designs(Designs),
    EducationalPhilosophy(EducationalPhilosophy),
    Memes(Memes),
    NixExamples(NixExamples),
    Qa(Qa),
    ReviewFindings(ReviewFindings),
    ShellScriptingStandards(ShellScriptingStandards),
    Sops(Sops),
    Tutorials(Tutorials),
    UserGuide(UserGuide),
    ExtremeNixismLlmManifesto,
    FlakeTutorial,
    FormalProofCrq,
    GitCommitSop,
    GitStatusIgnoreSubmodules,
    Glossary,
    Intent,
    LivestreamSetup,
    LocalBuildInstructions,
    NixConfigGitTutorial,
    NixForDebianUsers,
    NoobTutorial,
    ProjectObservations,
    SelfCreatingNixLlmOodaMeme,
    SolfunmemeCommunicationCrq,
    SopAdvancedMonadicAi,
    SopAutomatedSubmoduleUpdateProcess,
    SopDataRetentionAndImmutability,
    SopDocumentationConsolidation,
    SopLargeFileChunkingStrategy,
    SopNixExpressionRefactoringForSubmodules,
    SopNixFlakeIntegrationForExternalDependencies,
    SopSubmoduleManagementBestPractices,
    SubmoduleDocsIndex,
    Submodules,
}

/// Represents Change Request (CRQ) documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Crqs {
    BugReportNixOnDroidPathsIssue,
    CodebergMigrationCrq,
    CrqAutomateSubmoduleUpdates,
    CrqChunkLargeFiles,
    CRQEmacsConfigurableItemsAndHelp,
    CRQEmacsGUIDesignForGeminiCLI,
    CRQEmacsOrgModeIntegrationForGeminiCLI,
    CrqEnhanceNixFlakesIntegrationForSubmodules,
    CRQEnhanceTaskExecutionEfficiency,
    CrqOptimizeGitoxideIntegration,
    CrqRefactorNixExpressionForSubmoduleCheckout,
    CRQStandardizeTaskManagement,
    CrqStreamlineDocumentationWorkflow,
    IntrinsicNixFlakesProposal,
    SelfReflectingAgentCrq,
    UserspaceEbpfRootCauseCrq,
    WIKIIMPORTCRQ,
}

/// Represents design documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Designs {
    EmacsGeminiCLIGUIDesign,
}

/// Represents educational philosophy documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum EducationalPhilosophy {
    CompilingFromSourceLearning,
}

/// Represents meme-related documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Memes {
    TheStandardsOverloadMeme,
    TheMonadicCodeMeme,
    TheVibeAsCodeMeme,
    TheBlockchainEverythingMeme,
    TheSmartContractSubmoduleMeme,
    TheSelfVerifyingSoftwareMeme,
    TheSExpressionLinguaFrancaMeme,
    TheAIAgentMakingMemesAboutItselfMetaMeme,
    TheSopForMemesMetaMeme,
}

/// Represents Nix example documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum NixExamples {
    TempShell,
}

/// Represents Quality Assurance (QA) documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Qa {
    TracenixQaProcedure,
}

/// Represents review findings documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ReviewFindings {
    CRQSOPReview2025_09_16,
}

/// Represents shell scripting standards documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum ShellScriptingStandards {
    Readme,
    ScriptReviewFindings,
    ShellScriptBestPractices,
}

/// Represents Standard Operating Procedure (SOP) documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Sops {
    MemeIdentificationSop,
    MemeticCodeGenerationSop,
    MIBCRASHRETRIEVALPROTOCOL,
    SolfunmemeCommunicationSop,
    SopAddMkaiderivationSubmodule,
    SOPCRQSOPReviewAndTaskCreation,
    SOPEfficientTaskExecution,
    SOPEmacsConfigurableItemsAndHelpImplementation,
    SOPEmacsOrgModeIntegrationImplementation,
    SOPTaskManagementWorkflow,
    SopUpdateSubmodules,
    SUBMODULESETUPSOP,
}

/// Represents tutorial documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Tutorials {
    EmacsGeminiCLIIntegrationTutorial,
}

/// Represents user guide documents.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum UserGuide {
    TracenixUserGuide,
}