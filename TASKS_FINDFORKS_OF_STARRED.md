# Task List: findforks-of-starred.sh

## Current Status ✅
- **Created**: `/home/mdupont/2026/09/20/pick-up-nix/tools/findforks-of-starred.sh`
- **Features implemented**:
  - Fetch recently starred repos (GraphQL API)
  - Get forks for each starred repo (REST API)
  - Score forks by: PRs to upstream (+5), recent commits (+3), stars (+2), issues (+1)
  - Filter out inactive mirrors
  - Support `--dry-run` and `--onboard` flags
  - Works with `--since-days N` parameter
- **Location**: `~/nix/scripts/tools/findforks-of-starred.sh` and `/home/mdupont/2026/09/20/pick-up-nix/tools/findforks-of-starred.sh`

## Known Issues ❌
1. **GraphQL Query Execution**: `gh api graphql --field "query=...` syntax issues
2. **Query File Approach**: Using external query files with gh api is problematic
3. **Python String Escaping**: Complex quoting with f-strings and backslashes

## Tasks to Fix

### Priority 1 (Critical)
1. **Fix GraphQL query execution**
   - Problem: `--field "query=$query"` doesn't work properly
   - Solution: Use proper variable passing with `gh api graphql`
   - Files: `findforks-of-starred.sh` (function `get_recent_starred()`)

2. **Improve GraphQL variable passing**
   - Problem: Variables not being passed correctly
   - Solution: Ensure correct syntax for passing variables
   - Files: `findforks-of-starred.sh`

### Priority 2 (Important)
3. **Validate query syntax with GitHub's GraphQL API**
   - Test with simpler queries first
   - Ensure variables are properly escaped
   - Files: Test in `/tmp` directory

4. **Test the complete pipeline**
   - Mock data for testing
   - Manual verification of fork scoring logic
   - Files: `findforks-of-starred.sh`

### Priority 3 (Good to Have)
5. **Add error handling and logging**
   - Better error messages
   - Progress indicators
   - Files: `findforks-of-starred.sh`

6. **Add testing framework**
   - Unit tests for scoring logic
   - Test cases for filtering
   - Files: New test files or add to existing script

## Verification Tasks
7. **Test with a known starred repo**
   - Use a repo with actual forks (e.g., `meta-introspector/time-2026`)
   - Verify fork fetching works
   - Check scoring logic

8. **Test the `--dry-run` flag**
   - Verify dry run shows the expected output
   - Confirm no actual git operations are performed

9. **Test the `--onboard` flag**
   - Verify it would create mirrors and worktrees (in dry-run first)
   - Test remote setup logic

## Project Organization
10. **Document the script**
    - Add usage documentation
    - Document the scoring system
    - Files: README or inline comments

11. **Clean up temporary files**
    - Remove `/tmp/findforks-starred-query.graphql`
    - Clean up any test files created

12. **Final testing**
    - End-to-end testing with real repos
    - Verify the --since-days filtering works
    - Check that inactive mirrors are properly filtered out

## Next Steps
1. Fix the GraphQL query execution (Priority 1)
2. Once GraphQL works, test with a real repo (Task 7)
3. Test all command-line options (Task 8, 9)
4. Add documentation and clean up (Priority 3)
5. Final verification and documentation (Task 12)

## Blocked Dependencies
- Requires working GitHub API access
- Need valid GitHub token with appropriate permissions
- Need `gh` CLI installed and authenticated

## Potential Issues to Consider
- GitHub rate limiting on API calls
- Network connectivity issues
- Script permissions and execution context