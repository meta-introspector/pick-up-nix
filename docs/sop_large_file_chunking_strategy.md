# SOP: Large File Chunking Strategy

## Purpose
This Standard Operating Procedure (SOP) outlines an iterative and recursive strategy for breaking down large text files into smaller, more manageable chunks. This approach facilitates efficient processing, analysis, and storage by progressively refining chunk boundaries based on identified keywords and other criteria.

## Scope
This SOP applies to all large text files within the project that require chunking for improved handling, specifically including `~/nix2/file.txt` and `~/pick-up-nix2/file.txt`.

## Procedure
1.  **Initial Term Identification**: Begin by identifying the overall top N unique terms from the target large file(s) (e.g., the initial top 10 terms: `vendor`, `nixpkgs`, `pkgs`, `external`, `rust`, `tests`, `nix`, `name`, `rs`, `by`).
2.  **Initial Keyword-Based Chunking**: Utilize these initial terms to define primary chunk boundaries. A new chunk can be initiated whenever one of these keywords is encountered, or chunks can be created to encompass specific keyword occurrences.
3.  **Recursive Term Identification (Sub-Chunking)**:
    *   Select a significant keyword from the previous level of analysis (e.g., `vendor`).
    *   Filter the original large file(s) or the relevant chunks to isolate content associated with this keyword.
    *   From this filtered content, identify the next top N unique terms (e.g., for 'vendor': `vendor`, `nixpkgs`, `pkgs`, `external`, `rust`, `tests`, `nix`, `name`, `by`, `rs`).
4.  **Recursive Keyword-Based Chunking**: Apply the newly identified sub-terms to further break down the previously created chunks, creating a hierarchical structure of chunks.
5.  **File Ending-Based Chunking**: Implement chunking logic that identifies and splits files or chunks based on patterns resembling file endings (e.g., `.rs`, `.md`, `.nix`) if the content is structured in a way that these endings signify logical breaks.
6.  **Other Chunking Methods (Optional)**:
    *   **Fixed-Size Chunking**: Divide the file into chunks of a predetermined byte size or line count.
    *   **Context-Aware Chunking**: Develop more sophisticated logic that understands the file's structure (e.g., code blocks, log entries) to create semantically meaningful chunks.
7.  **Chunk Naming Convention**: Establish a consistent and hierarchical naming convention for generated chunks (e.g., `original_filename_chunk_keyword_level1_001_keyword_level2_001.txt`), reflecting the recursive nature of the chunking.
8.  **Storage Location**: Define a dedicated and hierarchical directory structure for storing the generated chunks, ensuring easy retrieval and organization.
9.  **Verification**: Implement automated checks to verify the integrity and correctness of the chunking process at each level of recursion, ensuring no data loss or corruption and that chunks are correctly formed.
10. **Documentation**: Document the specific chunking logic used for each file or file type, including the keywords, patterns, and methods applied at each recursive step.

## Origin
User request and analysis of `~/nix2/file.txt` and `~/pick-up-nix2/file.txt`.
