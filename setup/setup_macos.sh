#!/usr/bin/env bash
set -euo pipefail

GITHUB=false
REPO="cse30-python-starter"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --github) GITHUB=true; shift ;;
    --name) REPO="$2"; shift 2 ;;
    *) echo "Unknown arg: $1" ; exit 1 ;;
  esac
done

have() { command -v "$1" >/dev/null 2>&1; }

# Install Homebrew if missing
if ! have brew; then
  echo "Homebrew not found. Install from https://brew.sh/ then re-run this script."
  exit 1
fi

# Ensure tools
brew install git python@3.11 gh || true
brew install --cask visual-studio-code || true

# Use python3
PY=python3
$PY --version || (echo "Python not available" && exit 1)

# venv
if [ ! -d ".venv" ]; then
  $PY -m venv .venv
fi
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt

# VS Code extensions if code CLI is available
if have code; then
  code --install-extension ms-python.python --force || true
  code --install-extension ms-python.vscode-pylance --force || true
  code --install-extension ms-python.black-formatter --force || true
  code --install-extension ms-python.isort --force || true
  code --install-extension charliermarsh.ruff --force || true
  code --install-extension ms-toolsai.jupyter --force || true
else
  echo "Tip: Enable 'code' command from VS Code (Command Palette: Shell Command: Install 'code' command)."
fi

# git init
if [ ! -d ".git" ]; then
  git init
  git add .
  git commit -m "Initial commit: CSE30 Python starter"
fi

# pre-commit
pre-commit install

if $GITHUB; then
  if have gh; then
    gh repo create "$REPO" --source=. --public --push
  else
    echo "GitHub CLI not found. Install with: brew install gh"
  fi
fi

echo
echo "✅ Setup complete."
echo "Next:"
echo "1) source .venv/bin/activate"
echo "2) python src/main.py"
echo "3) pytest"
