#!/bin/bash

set -e

PYTHON_VERSION="3.8.16"
VENV_NAME="myenv"

sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libffi-dev wget

if ! command -v pyenv >/dev/null 2>&1; then
    curl https://pyenv.run | bash
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
else
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

pyenv install "$PYTHON_VERSION" --skip-existing
pyenv local "$PYTHON_VERSION"

rm -rf "$VENV_NAME"
python -m venv "$VENV_NAME"
source "$VENV_NAME/bin/activate"

echo "To activate the virtual environment, run:"
echo "source $VENV_NAME/bin/activate"