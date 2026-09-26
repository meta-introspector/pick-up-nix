// This module defines enums related to prompt files and their outputs.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Prompts {
    Task000ReviewStatus(PromptsTask000ReviewStatus),
    OldReviewSubmodule,
    NixTemplate,
    Postlude,
    Prelude,
    ProOneshotTask,
    ReviewSubmoduleTask1,
    ReviewSubmoduleTask2,
    ReviewSubmodule,
    ScriptInfo,
    SlidingWindow,
    SopNix,
    Task000ReviewStatusMd,
    Task001EmacsLisp,
    Task002EfficientExecution,
    Task003EmacsOrgMode,
    Task004EmacsGui,
    Task005EmacsConfigHelp,
    Task006TaskManagementWorkflow,
    TaskAinix,
    TaskAutomateSubmoduleUpdates,
    TaskCargo,
    TaskChunkLargeFiles,
    TaskCommit,
    TaskCrq,
    TaskCrqs,
    TaskEnhanceNixFlakesIntegrationForSubmodules,
    TaskGeminiTelemetry,
    TaskGeminiCli,
    TaskGitmodules,
    TaskIdea,
    TaskOptimizeGitoxideIntegration,
    TaskPlanReviewSubmodule,
    TaskReadProjectTasks,
    TaskRefactorNixExpressionForSubmoduleCheckout,
    TaskReproducibleMeme,
    TaskReviewSubmoduleLlm,
    TaskReviewSubmodule2,
    TaskReviewSubmodule3,
    TaskSlidingWindow,
    TaskSlidingWindow2,
    TaskSop,
    TaskStreamlineDocumentationWorkflow,
    TaskEnhanceNixRustIntegration,
    TaskGitAutomation,
    TaskIntegrateTestAmazonQCli,
    TaskIntegrateTestGitoxide,
    TaskIntegrateValidateExternalRustSubmodules,
    TaskIntegrateValidateSteelStrace,
    TaskManageVerifyRustCompiler,
    TaskMemeTheorySim,
    TaskMetaAiConcepts,
    TaskPodcastEpisodeGenerator,
    TaskQaCompliance,
    TaskRefactorCoreGitSubmoduleTools,
    TaskReviewConsolidateRootCrates,
    TaskReviewIntegrateEbpfCrates,
    TaskReviewNixpacksExamples,
    TaskRustWorkspaceInit,
    TaskSyncValidateSubmodulesMirror,
    TaskZosStructure,
}

/// Represents outputs for `task_000_review_status` prompts.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum PromptsTask000ReviewStatus {
    Outputs(PromptsTask000ReviewStatusOutputs),
}

/// Represents specific output files for `task_000_review_status`.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum PromptsTask000ReviewStatusOutputs {
    Out20250916211828,
}