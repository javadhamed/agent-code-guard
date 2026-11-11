---
name: knip-dead-code-cleanup
description: Detect and eliminate unused files, unused exports, unused types, and unreferenced dependencies in JavaScript and TypeScript projects using Knip.
---

# Knip Dead Code Cleanup Skill

Use Knip to find and remove dead code, unused exports, unused files, and redundant dependencies in JavaScript and TypeScript codebases.

## When to Run Knip
- During refactoring tasks or code simplification.
- Before submitting a Pull Request or completing a major feature.
- When optimizing bundle size or cleaning up technical debt.

## Common Workflows

### 1. Audit Project for Dead Code & Unused Dependencies
Run from the root of a JS/TS project:
```powershell
npx knip
```

### 2. Machine-Readable Audit (JSON Output for Agent Parsing)
Extract structured findings to evaluate files, unused exports, and dependencies:
```powershell
npx knip --reporter json
```

### 3. Automated Fix (Remove Unused Exports & Types)
Automatically remove unused code where safe:
```powershell
npx knip --fix
```

### 4. Focused Checks
- **Only unused files & dependencies:**
  ```powershell
  npx knip --dependencies --include-files
  ```
- **Only unused exports & types:**
  ```powershell
  npx knip --include-libs
  ```
