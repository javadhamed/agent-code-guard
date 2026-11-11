---
name: lefthook-git-hooks
description: Manage ultra-fast, parallel Git hooks using Lefthook to automate Gitleaks, Knip, jscpd, and OSV-Scanner checks.
---

# Lefthook Git Hooks Skill

Use Lefthook to automate pre-commit, pre-push, and custom Git hooks across projects with parallel execution.

## Common Workflows

### 1. Initialize Lefthook in a Git Repository
Generate default `lefthook.yml` and install Git hooks:
```powershell
lefthook install
```

### 2. Run Hooks Manually
Test hooks without making a commit:
```powershell
# Run pre-commit checks
lefthook run pre-commit

# Run all hooks
lefthook run pre-commit --all-files
```

### 3. Recommended Universal `lefthook.yml`
```yaml
pre-commit:
  parallel: true
  commands:
    gitleaks:
      tags: security secrets
      run: gitleaks protect --staged --verbose
    jscpd:
      tags: quality dry
      run: npx jscpd {staged_files} --threshold 5
    knip:
      tags: quality dead-code
      glob: "*.{js,ts,jsx,tsx}"
      run: npx knip

pre-push:
  parallel: false
  commands:
    osv-scanner:
      tags: security vulnerabilities
      run: osv-scanner -r .
```
