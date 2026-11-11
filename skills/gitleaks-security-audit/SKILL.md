---
name: gitleaks-security-audit
description: Run Gitleaks secret detection scans on git repositories, diffs, staged changes, or directories to detect leaked keys, passwords, and sensitive tokens.
---

# Gitleaks Security Audit Skill

Use Gitleaks to detect hardcoded secrets (API keys, private keys, authentication tokens, credentials) in repositories and working directories.

## Common Workflows

### 1. Protect Staged Changes (Pre-commit check)
Before committing, scan only staged changes:
```powershell
gitleaks protect --staged --verbose
```
If secrets are found, gitleaks will return exit code `1` and print the exact line and secret rule matched.

### 2. Full History Audit
Scan the entire git history of the current repository:
```powershell
gitleaks detect --verbose
```

### 3. Generate JSON Report for Automation
Produce structured JSON output to analyze programmatically:
```powershell
gitleaks detect --report-path gitleaks-report.json --report-format json
```

### 4. Scan an Uncommitted Directory or Specific Path
Scan a specific folder without evaluating git history:
```powershell
gitleaks dir <path-to-folder> --verbose
```

## Adding as a Git Pre-commit Hook
To enforce protection automatically in any git repo:
```powershell
# In the repo root:
$hookContent = @"
#!/bin/sh
gitleaks protect --staged --verbose
"@
Set-Content -Path ".git/hooks/pre-commit" -Value $hookContent
```
