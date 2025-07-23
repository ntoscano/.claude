Perform a comprehensive code review on the changes in $ARGUMENTS:

Context: !`git diff --stat`
Changes: !`git diff`
Build status: !`npm run build 2>&1 | tail -20`
Test results: !`npm test 2>&1 | tail -30`

Review for:
1. Logic errors and edge cases
2. Performance implications
3. Security vulnerabilities  
4. Code style consistency
5. Test coverage adequacy
6. Documentation completeness

Provide actionable feedback with specific line references.