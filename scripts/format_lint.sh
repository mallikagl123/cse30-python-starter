#!/usr/bin/env bash
set -euo pipefail
black .
ruff check . --fix
isort .
echo "✅ Formatting and linting completed."
