# SOP: Data Retention and Immutability Policy

**Date:** 2025-09-08

## 1. Purpose

This Standard Operating Procedure (SOP) establishes a strict policy regarding data retention and immutability within the project. Its purpose is to ensure the complete preservation of all project artifacts, including code, documentation, configurations, and historical records. This policy is fundamental to maintaining auditability, reproducibility, and the integrity of our development process, aligning with principles of formal verification and robust quality assurance.

## 2. Scope

This SOP applies to all data generated, modified, or used within the project, encompassing:
*   Source code files
*   Documentation (SOPs, CRQs, design documents, etc.)
*   Configuration files
*   Test scripts and results
*   Build logs and reports
*   Any other digital artifact contributing to the project's history or functionality.

## 3. Policy: Never Delete Anything

The core principle of this policy is that **no project artifact shall ever be permanently deleted or removed from version control or designated archival storage.**

## 4. Handling "Deletion" (Deprecation, Archiving, Obsoletion)

Instead of deletion, the following procedures shall be followed when an artifact is no longer actively used or is deemed obsolete:

### 4.1. Deprecation

*   **Definition:** An artifact is marked as deprecated when it is superseded by a newer version or alternative, but may still be referenced or required by older components.
*   **Procedure:**
    *   Mark the artifact as deprecated within its content (e.g., adding a "DEPRECATED" header to a document, using `@deprecated` annotations in code).
    *   Update any references to the deprecated artifact to point to its successor, if applicable.
    *   Do NOT remove the deprecated artifact from the repository.

### 4.2. Archiving

*   **Definition:** Artifacts that are no longer actively used but must be retained for historical, legal, or audit purposes.
*   **Procedure:**
    *   Move the artifact to a designated `archive/` directory within its respective section (e.g., `docs/archive/`, `scripts/archive/`).
    *   Add a `README.md` file within the `archive/` directory explaining the purpose of the archived contents and the date of archiving.
    *   Ensure the artifact remains under version control.

### 4.3. Obsoletion

*   **Definition:** Artifacts that are no longer relevant or functional but whose historical record must be preserved.
*   **Procedure:**
    *   Similar to deprecation, mark the artifact as obsolete within its content.
    *   Ensure it remains in its original location under version control.
    *   Document the reason for obsoletion in relevant CRQs or project logs.

## 5. Rationale

This policy is driven by several critical considerations:

*   **Auditability:** Provides a complete, immutable history of all changes, essential for compliance, debugging, and understanding project evolution.
*   **Reproducibility:** Ensures that any past state of the project can be accurately recreated, which is vital for Nix-based systems and formal verification.
*   **Historical Context:** Preserves the rationale behind decisions, even if those decisions were later revised.
*   **Formal Verification:** Supports the goal of formally verifying project artifacts by ensuring their persistent availability for analysis and proof.
*   **Zero-Knowledge Proofs (ZKP):** An immutable history is a prerequisite for constructing ZKPs about the project's evolution and properties.

## 6. Compliance

Adherence to this SOP is mandatory for all project contributors. Any deviation must be formally justified and approved through a Change Request process.

## 7. Immediate Next Action

The immediate next action is to review existing project practices and ensure they align with this new policy. Specifically, the previous action of deleting test scripts will be reversed by restoring them from Git history.
