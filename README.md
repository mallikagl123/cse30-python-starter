# CSE30 Python Starter (UCSC) — VS Code + Git + Pre-commit

This starter is designed for **CSE30: Abstractions in Python** and avoids Colab/IDLE.
It gives you:
- Local Python project with virtual environment
- VS Code configured (formatter, linter, tests, debug)
- Git initialized + ready for GitHub
- Pre-commit hooks (Black, Ruff, isort)
- Basic tests via pytest

## Quick Start

> Choose your OS and run the appropriate setup script from a terminal **inside this folder**.

### Windows (PowerShell)
```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
./setup/setup_windows.ps1 -CreateGitHubRepo:$false
```
- To create a GitHub repo automatically (requires GitHub CLI `gh` and that you are logged in):
```powershell
./setup/setup_windows.ps1 -CreateGitHubRepo:$true -RepoName "cse30-python-starter"
```

### macOS (zsh/bash)
```bash
chmod +x ./setup/setup_macos.sh
./setup/setup_macos.sh
```
- To create a GitHub repo (requires `gh` installed & logged in):
```bash
./setup/setup_macos.sh --github --name "cse30-python-starter"
```

### Linux (Ubuntu/Debian-like)
```bash
chmod +x ./setup/setup_linux.sh
./setup/setup_linux.sh
```
- To create a GitHub repo (requires `gh` installed & logged in):
```bash
./setup/setup_linux.sh --github --name "cse30-python-starter"
```

## What the scripts do
- Install (or verify) **Python 3.11+**, **Git**, **VS Code** (where possible)
- Create a **.venv** and install: `pytest`, `black`, `ruff`, `isort`, `pre-commit`
- Configure VS Code extensions (Python, Pylance, Black, isort, Ruff, Jupyter) if `code` CLI is available
- Initialize **git**, set up **pre-commit**, make the **first commit**
- Optionally create a **GitHub** repository and push

If any automatic install step can't run on your system, the script prints exact manual commands to finish.

## Project Layout
```
.
├── .github/workflows/python-tests.yml   # CI: run tests on push
├── .pre-commit-config.yaml
├── .editorconfig
├── .gitignore
├── .vscode/
│   ├── extensions.json
│   ├── launch.json
│   └── settings.json
├── LICENSE
├── README.md
├── pyproject.toml
├── requirements.txt
├── scripts/
│   ├── format_lint.sh
│   └── format_lint.ps1
├── setup/
│   ├── setup_linux.sh
│   ├── setup_macos.sh
│   └── setup_windows.ps1
├── src/
│   ├── __init__.py
│   └── main.py
└── tests/
    └── test_sample.py
```

## Daily Workflow
```bash
# activate venv first (see the script output for your OS)
python src/main.py
pytest -q

# format & lint
black .
ruff check . --fix
isort .
```

## VS Code Tips
- Press **F5** to debug the current file or run tests (see `.vscode/launch.json`).
- When VS Code asks for a Python interpreter, select **.venv** in this folder.
- If the `code` CLI isn't on your PATH, see VS Code docs for “Shell Command: Install 'code' command”.

---

MIT License. Enjoy CSE30 🎉
