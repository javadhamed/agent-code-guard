---
name: jscpd-duplicate-code-detection
description: Detect duplicate code, copy-paste blocks, and clones across 150+ programming languages using jscpd to enforce DRY principles and guide refactoring.
---

# jscpd Duplicate Code Detection Skill

Use `jscpd` to scan codebases for copy-pasted blocks and duplicate logic across multiple files or modules.

## When to Run jscpd
- During refactoring and code simplification tasks.
- When auditing technical debt or assessing codebase maintainability.
- Before PR review to ensure new code does not introduce unnecessary duplication (DRY violation).

## Common Workflows

### 1. Basic Scan
Scan a target directory (e.g., `./src` or current directory):
```powershell
npx jscpd ./src
```

### 2. Machine-Readable Audit (JSON Output for Agent Analysis)
Generate a JSON report inside a specified output directory:
```powershell
npx jscpd ./src --reporters json --output ./report
```

### 3. Set a Duplication Threshold
Fail or alert if duplication exceeds a percentage (e.g., 5%):
```powershell
npx jscpd ./src --threshold 5
```

### 4. Ignore Generated Files, Tests, or Dependencies
```powershell
npx jscpd ./src --ignore "**/*.min.js,**/*.test.*,**/*.spec.*,**/vendor/**"
```

### 5. Tune Clone Detection Sensitivity
- `--min-lines <number>`: Minimum lines of duplication to match (default: 5)
- `--min-tokens <number>`: Minimum tokens of duplication to match (default: 50)
```powershell
npx jscpd ./src --min-lines 10 --min-tokens 60
```
