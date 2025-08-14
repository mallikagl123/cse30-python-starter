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

# Try to install dependencies on Debian/Ubuntu
if have apt; then
  sudo apt update
  sudo apt install -y git python3 python3-venv python3-pip
  # VS Code: user may need to follow MS repo instructions if 'code' is not available
  if ! have code; then
    echo "VS Code CLI not found. See: https://code.visualstudio.com/docs/setup/linux"
  fi
elif have dnf; then
  sudo dnf install -y git python3 python3-venv python3-pip
  echo "For VS Code on Fedora: https://code.visualstudio.com/docs/setup/linux"
elif have pacman; then
  sudo pacman -S --noconfirm git python python-pip
  echo "For VS Code on Arch: https://code.visualstudio.com/docs/setup/linux"
else
  echo "Please install Git, Python 3.11+, and VS Code using your distro's package manager."
fi

PY=python3
$PY --version || (echo "Python not available" && exit 1)

# venv
if [ ! -d ".venv" ]; then
  $PY -m venv .venv
fi
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt

# VS Code extensions if code CLI available
if have code; then
  code --install-extension ms-python.python --force || true
  code --install-extension ms-python.vscode-pylance --force || true
  code --install-extension ms-python.black-formatter --force || true
  code --install-extension ms-python.isort --force || true
  code --install-extension charliermarsh.ruff --force || true
  code --install-extension ms-toolsai.jupyter --force || true
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
    echo "GitHub CLI not found. Install from your distro or https://cli.github.com/"
  fi
fi

echo
echo "✅ Setup complete."
echo "Next:"
echo "1) source .venv/bin/activate"
echo "2) python src/main.py"
echo "3) pytest"
