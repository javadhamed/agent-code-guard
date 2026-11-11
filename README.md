# agent-code-guard
Universal security, code quality, and dependency guardrails for AI coding agents and human engineers.

Built for **Google Antigravity**, **Claude Code**, **Codex**, **Cursor**, and modern Git workflows.

---

## What is agent-code-guard?

AI agents write code at superhuman speed, but speed without guardrails introduces risks:
- ❌ Leaking API keys, tokens, or credentials into Git history.
- ❌ Committing unvetted third-party packages with known CVE vulnerabilities.
- ❌ Accumulating dead code, unused exports, and unneeded dependencies.
- ❌ Spreading duplicate copy-pasted code blocks across files (DRY violations).

**`agent-code-guard`** bundles production-grade CLI tools, native AI skills, system prompt rules, and blazing-fast parallel Git hooks into a **one-click setup**.

---

## Included Arsenal

| Tool | Engine | What It Protects |
| :--- | :--- | :--- |
| 🛡️ **Gitleaks** | Go binary | Prevents hardcoded API keys, private tokens, and credentials from entering commits. |
| 🔍 **OSV-Scanner** | Go binary (Google) | Scans lockfiles & manifests for known CVEs against Google's OSV.dev database. |
| ⚡ **Lefthook** | Go binary (Evil Martians) | Orchestrates parallel pre-commit & pre-push checks in milliseconds with zero overhead. |
| 🧹 **Knip** | Node / npm | Detects and removes unused files, dead exports, unused types, and unreferenced packages. |
| 📋 **jscpd** | Node / npm | Detects duplicate and copy-pasted code blocks across 150+ programming languages. |

---

## One-Line Installation

### Windows (PowerShell)
Run PowerShell as Administrator or regular user:
```powershell
irm https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/install.ps1 | iex
```

### Linux & macOS (Bash)
```bash
curl -fsSL https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/install.sh | bash
```

The installer will:
1. Download standalone binaries for **Gitleaks**, **OSV-Scanner**, and **Lefthook** into your user tools directory.
2. Add tool paths to your user `PATH`.
3. Verify `npx` availability for **Knip** and **jscpd**.
4. Automatically register native Antigravity skills into your global config (`~/.gemini/config/skills/`).

---

## How It Works in Your Projects

### 1. Initialize in Any Git Repository
Inside any project repository:
```bash
# Apply pre-configured parallel hooks
agent-guard-init
# or manually copy lefthook.yml
lefthook install
```

### 2. Universal Git Hooks (`lefthook.yml`)
When you (or an AI agent) run `git commit` or `git push`, Lefthook runs checks in parallel:
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

---

## Antigravity AI Skills

This package includes native AI Agent Skills located in `skills/`:
- `gitleaks-security-audit`: Secrets and credential leak audit.
- `osv-scanner-vulnerability-audit`: Software supply chain vulnerability scanner.
- `knip-dead-code-cleanup`: Dead code and dependency eliminator.
- `jscpd-duplicate-code-detection`: Copy-paste code detector.
- `lefthook-git-hooks`: Fast Git hook manager.

### System Prompt Rules (`rules/AGENTS.md`)
Copy `rules/AGENTS.md` into your project root or AI agent config to instruct AI models to automatically respect and enforce these guardrails during refactoring and commits.

---

## License

[Apache 2.0](LICENSE) © [Javad Hamed](https://github.com/javadhamed)
