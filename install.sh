#!/usr/bin/env bash
set -e

echo "=============================================="
echo " Installing agent-code-guard for Linux/macOS  "
echo "=============================================="

INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "$ARCH" in
  x86_64) ARCH_GO="amd64" ;;
  aarch64|arm64) ARCH_GO="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# 1. Gitleaks
echo "[1/4] Installing Gitleaks..."
GITLEAKS_URL="https://github.com/gitleaks/gitleaks/releases/download/v8.30.1/gitleaks_8.30.1_${OS}_${ARCH_GO}.tar.gz"
curl -fsSL "$GITLEAKS_URL" | tar -xz -C "$INSTALL_DIR" gitleaks
chmod +x "$INSTALL_DIR/gitleaks"

# 2. OSV-Scanner
echo "[2/4] Installing OSV-Scanner..."
OSV_URL="https://github.com/google/osv-scanner/releases/download/v2.7.0/osv-scanner_${OS}_${ARCH_GO}"
curl -fsSL -o "$INSTALL_DIR/osv-scanner" "$OSV_URL"
chmod +x "$INSTALL_DIR/osv-scanner"

# 3. Lefthook
echo "[3/4] Installing Lefthook..."
if [ "$OS" = "darwin" ]; then
  LEFTHOOK_OS="MacOS"
else
  LEFTHOOK_OS="Linux"
fi
LEFTHOOK_URL="https://github.com/evilmartians/lefthook/releases/download/v2.2.2/lefthook_2.2.2_${LEFTHOOK_OS}_${ARCH}.gz"
curl -fsSL "$LEFTHOOK_URL" | gunzip -c > "$INSTALL_DIR/lefthook"
chmod +x "$INSTALL_DIR/lefthook"

# 4. Helper agent-guard-init
cat << 'EOF' > "$INSTALL_DIR/agent-guard-init"
#!/usr/bin/env bash
if [ ! -f lefthook.yml ]; then
  echo "Creating default lefthook.yml..."
  curl -fsSL https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/templates/lefthook.yml -o lefthook.yml
fi
lefthook install
echo "[agent-code-guard] Git hooks installed successfully!"
EOF
chmod +x "$INSTALL_DIR/agent-guard-init"

# 5. Antigravity Skills
echo "[4/4] Registering Antigravity AI Skills..."
GEMINI_SKILLS="$HOME/.gemini/config/skills"
if [ -d "$HOME/.gemini" ]; then
  mkdir -p "$GEMINI_SKILLS"
  SKILLS=("gitleaks-security-audit" "knip-dead-code-cleanup" "jscpd-duplicate-code-detection" "osv-scanner-vulnerability-audit" "lefthook-git-hooks")
  for s in "${SKILLS[@]}"; do
    mkdir -p "$GEMINI_SKILLS/$s"
    curl -fsSL "https://raw.githubusercontent.com/javadhamed/agent-code-guard/main/skills/$s/SKILL.md" -o "$GEMINI_SKILLS/$s/SKILL.md"
  done
  echo "   -> Skills registered in $GEMINI_SKILLS"
fi

echo "=============================================="
echo " Installation Complete!                       "
echo " Ensure $INSTALL_DIR is in your PATH.         "
echo " Run 'agent-guard-init' inside any repo.      "
echo "=============================================="
