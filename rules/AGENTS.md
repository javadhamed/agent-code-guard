# AI Agent Quality & Security Rules

## Core Engineering Principles
1. **Plan First**: Outline the architecture and plan before generating code.
2. **Test-Driven Design (TDD)**: Verify or create unit tests before touching critical paths.
3. **Security by Default**:
   - Never output, log, or commit API keys, secrets, or bearer tokens. Always verify with Gitleaks (`gitleaks protect --staged`).
   - Audit dependencies and lockfiles for known vulnerabilities using OSV-Scanner (`osv-scanner -r .`) before releases.
   - Validate and sanitize input at public boundaries.
4. **Code Quality & DRY**:
   - In JS/TS codebases, use Knip (`npx knip`) during refactoring and PR reviews to eliminate dead code and unreferenced dependencies.
   - Enforce DRY principles using jscpd (`npx jscpd <path>`) to detect duplicate copy-pasted blocks.
5. **Fast Git Gateways**:
   - Use Lefthook to orchestrate pre-commit and pre-push validations in parallel.
