# agent-code-guard 🛡️

[English](#english) | [فارسی](#persian)

---

<a name="english"></a>
## English

Universal security, code quality, and dependency guardrails for AI coding agents and human engineers.

Built for **Google Antigravity**, **Claude Code**, **Codex**, **Cursor**, and modern Git workflows.

### What is agent-code-guard?

AI agents write code at superhuman speed, but speed without guardrails introduces risks:
- ❌ Leaking API keys, tokens, or credentials into Git history.
- ❌ Committing unvetted third-party packages with known CVE vulnerabilities.
- ❌ Accumulating dead code, unused exports, and unneeded dependencies.
- ❌ Spreading duplicate copy-pasted code blocks across files (DRY violations).

**`agent-code-guard`** bundles production-grade CLI tools, native AI skills, system prompt rules, and blazing-fast parallel Git hooks into a **one-click setup**.

### Included Arsenal

| Tool | Engine | What It Protects |
| :--- | :--- | :--- |
| 🛡️ **Gitleaks** | Go binary | Prevents hardcoded API keys, private tokens, and credentials from entering commits. |
| 🔍 **OSV-Scanner** | Go binary (Google) | Scans lockfiles & manifests for known CVEs against Google's OSV.dev database. |
| ⚡ **Lefthook** | Go binary (Evil Martians) | Orchestrates parallel pre-commit & pre-push checks in milliseconds with zero overhead. |
| 🧹 **Knip** | Node / npm | Detects and removes unused files, dead exports, unused types, and unreferenced packages. |
| 📋 **jscpd** | Node / npm | Detects duplicate and copy-pasted code blocks across 150+ programming languages. |

### One-Line Installation

#### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/install.ps1 | iex
```

#### Linux & macOS (Bash)
```bash
curl -fsSL https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/install.sh | bash
```

The installer will:
1. Download standalone binaries for **Gitleaks**, **OSV-Scanner**, and **Lefthook** into your user tools directory.
2. Add tool paths to your user `PATH`.
3. Verify `npx` availability for **Knip** and **jscpd**.
4. Automatically register native Antigravity skills into your global config (`~/.gemini/config/skills/`).

### How It Works in Your Projects

Inside any Git repository:
```bash
# Initialize hooks automatically
agent-guard-init
# or manually via lefthook
lefthook install
```

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

<a name="persian"></a>
## فارسی

گاردریل‌های همه‌جانبه‌ی امنیت، سلامت و کیفیت کد برای ایجنت‌های هوش مصنوعی و توسعه‌دهندگان نرم‌افزار.

طراحی و بهینه‌سازی شده برای **Google Antigravity**، **Claude Code**، **Codex**، **Cursor** و تمام مخازن مدرن گیت.

### ابزار agent-code-guard چیست؟

دستیاران هوش مصنوعی با سرعتی شگفت‌انگیز کدنویسی می‌کنند، اما سرعت بدون گاردریل خطرات جدی به همراه دارد:
- ❌ نشت تصادفی توکن‌ها، کلیدهای API و پسوردها در تاریخچه گیت.
- ❌ اضافه شدن کتابخانه‌ها و پکیج‌های شخص‌ثالث با آسیب‌پذیری‌های امنیتی شناخته‌شده (CVE).
- ❌ انباشت کدهای مرده، اکسپورت‌های اضافی و وابستگی‌های بلااستفاده.
- ❌ تکثیر کدهای کپی‌پیشت‌شده و تکراری بین فایل‌ها و نقض اصل DRY.

بسته **`agent-code-guard`** قوی‌ترین ابزارهای استانداردهای صنعتی، مهارت‌های محلی هوش مصنوعی، قوانین پرامپت سیستمی و هوک‌های موازی و فوق‌سریع گیت را در قالب یک **نصب تک‌کلیکه** تجمیع کرده است.

### ابزارهای همراه پکیج

| ابزار | هسته اجرایی | حوزه حفاظت |
| :--- | :--- | :--- |
| 🛡️ **Gitleaks** | باینری Go | جلوگیری از ورود اطلاعات حساس، توکن‌ها و کلیدهای محرمانه به کامیت‌ها. |
| 🔍 **OSV-Scanner** | باینری Go (گوگل) | اسکن قفل‌فایل‌ها و مانیفست‌ها برای آسیب‌پذیری‌های امنیتی دیتابیس OSV.dev. |
| ⚡ **Lefthook** | باینری Go (تیم Evil Martians) | ارکستراسیون موازی هوک‌های پیش از کامیت و پوش با سرعت بسیار بالا. |
| 🧹 **Knip** | محیط Node / npm | کشف و حذف فایل‌های مرده، تایپ‌های بلااستفاده و وابستگی‌های اضافی در JS/TS. |
| 📋 **jscpd** | محیط Node / npm | شناسایی قطعه‌کدهای تکراری و کپی‌پیشت‌شده در بیش از ۱۵۰ زبان برنامه‌نویسی. |

### نصب تک‌خطی و آسان

#### ویندوز (PowerShell)
```powershell
irm https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/install.ps1 | iex
```

#### لینوکس و مک (Bash)
```bash
curl -fsSL https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/install.sh | bash
```

اسکریپت نصب به صورت خودکار:
۱. باینری‌های مستقل **Gitleaks**، **OSV-Scanner** و **Lefthook** را دانلود و در پوشه ابزارها ذخیره می‌کند.  
۲. مسیر آن‌ها را به متغیر `PATH` سیستم اضافه می‌کند.  
۳. مهارت‌های بومی را در مسیر تنظیمات Antigravity سیستم شما (`~/.gemini/config/skills/`) ثبت می‌کند.

### نحوه استفاده در پروژه‌ها

در ریشه هر ریپازیتوری گیت کافی است دستور زیر را اجرا کنید:
```bash
agent-guard-init
```
از این پس در هر بار کامیت یا پوش تغییرات، تمامی چک‌ها به صورت موازی در کسری از ثانیه اجرا شده و از سلامت و امنیت کد اطمینان حاصل می‌شود.

---

## 💖 Acknowledgements & Credits

`agent-code-guard` stands on the shoulders of these incredible open-source tools and their creators:

- **[Gitleaks](https://github.com/gitleaks/gitleaks)** — Built with passion by [Zachary Rice](https://github.com/zricethezav) (`@zricethezav`). Essential protection against secret leaks.
- **[Lefthook](https://github.com/evilmartians/lefthook)** — Created by [Evil Martians](https://evilmartians.com) and maintained by [Alex Krasnov](https://github.com/mrexox) & team. Blazing-fast Git hooks manager.
- **[OSV-Scanner](https://github.com/google/osv-scanner)** — Developed by the [Google Open Source Security Team](https://github.com/google) and the [OSV.dev](https://osv.dev) community.
- **[Knip](https://github.com/webpro-nl/knip)** — Masterfully crafted by [Lars Kappert](https://github.com/webpro) (`@webpro`). The ultimate dead code eliminator for JS/TS.
- **[jscpd](https://github.com/kucherenko/jscpd)** — Created and maintained by [Andrey Kucherenko](https://github.com/kucherenko). Multi-language duplicate code detection engine.

Thank you to all the maintainers for keeping the software ecosystem clean, fast, and secure!

---

## ⭐ Star & Support | حمایت از پروژه

If you find this project useful for securing your repositories and AI workflows, please consider giving it a **Star** on GitHub! It helps more developers and agents discover these guardrails.

اگر این پروژه برای امنیت و کیفیت کدهای شما و دستیاران هوش مصنوعیتان مفید بود، لطفاً با دادن **ستاره (Star)** در بالای صفحه گیت‌هاب از توسعه آن حمایت کنید. حمایت شما باعث دیده‌شدن بیشتر این پروژه توسط جامعه توسعه‌دهندگان خواهد شد. ⭐

---

## License

[Apache 2.0](LICENSE) © [Javad Hamed](https://github.com/javadhamed)
