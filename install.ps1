# agent-code-guard Windows Installer
$ErrorActionPreference = "Stop"

Write-Host "==============================================" -ForegroundColor Cyan
Write-Host " Installing agent-code-guard for Windows...  " -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

$baseDir = "$env:LOCALAPPDATA\Programs\agent-code-guard"
$binDir = "$baseDir\bin"
if (!(Test-Path $binDir)) { New-Item -ItemType Directory -Path $binDir -Force | Out-Null }

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 1. Install Gitleaks
Write-Host "[1/5] Installing Gitleaks..." -ForegroundColor Yellow
$gitleaksZip = "$env:TEMP\gitleaks.zip"
Invoke-WebRequest -Uri "https://github.com/gitleaks/gitleaks/releases/download/v8.30.1/gitleaks_8.30.1_windows_x64.zip" -OutFile $gitleaksZip -UserAgent "agent-guard-installer"
Expand-Archive -Path $gitleaksZip -DestinationPath $binDir -Force
Remove-Item $gitleaksZip -Force

# 2. Install OSV-Scanner
Write-Host "[2/5] Installing OSV-Scanner..." -ForegroundColor Yellow
$osvPath = "$binDir\osv-scanner.exe"
Invoke-WebRequest -Uri "https://github.com/google/osv-scanner/releases/download/v2.7.0/osv-scanner_windows_amd64.exe" -OutFile $osvPath -UserAgent "agent-guard-installer"

# 3. Install Lefthook
Write-Host "[3/5] Installing Lefthook..." -ForegroundColor Yellow
$lefthookPath = "$binDir\lefthook.exe"
Invoke-WebRequest -Uri "https://github.com/evilmartians/lefthook/releases/download/v2.2.2/lefthook_2.2.2_Windows_x86_64.exe" -OutFile $lefthookPath -UserAgent "agent-guard-installer"

# 4. Create helper shortcut `agent-guard-init`
$initScript = @"
@echo off
if not exist lefthook.yml (
    echo Creating default lefthook.yml...
    curl -fsSL https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/templates/lefthook.yml -o lefthook.yml
)
lefthook install
echo [agent-code-guard] Git hooks installed successfully!
"@
Set-Content -Path "$binDir\agent-guard-init.cmd" -Value $initScript

# 5. Add to User PATH
Write-Host "[4/5] Updating User PATH environment variable..." -ForegroundColor Yellow
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$binDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$binDir", "User")
}
$env:Path = "$env:Path;$binDir"

# 6. Install Antigravity Skills if Antigravity / Gemini config exists
Write-Host "[5/5] Registering Antigravity AI Skills..." -ForegroundColor Yellow
$geminiSkillsDir = "$env:USERPROFILE\.gemini\config\skills"
if (Test-Path "$env:USERPROFILE\.gemini") {
    if (!(Test-Path $geminiSkillsDir)) { New-Item -ItemType Directory -Path $geminiSkillsDir -Force | Out-Null }
    $skills = @(
        "gitleaks-security-audit",
        "knip-dead-code-cleanup",
        "jscpd-duplicate-code-detection",
        "osv-scanner-vulnerability-audit",
        "lefthook-git-hooks"
    )
    foreach ($s in $skills) {
        $skillTarget = "$geminiSkillsDir\$s"
        if (!(Test-Path $skillTarget)) { New-Item -ItemType Directory -Path $skillTarget -Force | Out-Null }
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/skills/$s/SKILL.md" -OutFile "$skillTarget\SKILL.md" -UserAgent "agent-guard-installer"
    }
    Write-Host "   -> Antigravity skills registered in $geminiSkillsDir" -ForegroundColor Green
}

Write-Host "==============================================" -ForegroundColor Green
Write-Host " Installation Complete!                       " -ForegroundColor Green
Write-Host " Run 'agent-guard-init' inside any repo.      " -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
