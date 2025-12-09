#!/bin/bash

set -e

PYTHON_VERSION="3.8.16"
VENV_NAME="myenv"
 
OS="$(uname -s)"

echo "Detected OS: $OS"

if [[ "$OS" == "Linux" ]]; then
    echo "Installing dependencies for Linux..."
    sudo apt-get update
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libffi-dev wget curl

elif [[ "$OS" == "Darwin" ]]; then
    echo "Installing dependencies for macOS..."

    # Check for Homebrew
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
        eval "$(/usr/local/bin/brew shellenv)"      # Intel
    fi

    brew update
    brew install openssl zlib readline sqlite wget curl pyenv

else
    echo "Unsupported OS: $OS"
    exit 1
fi


if ! command -v pyenv >/dev/null 2>&1; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

pyenv install "$PYTHON_VERSION" --skip-existing
pyenv local "$PYTHON_VERSION"

rm -rf "$VENV_NAME"
python -m venv "$VENV_NAME"
source "$VENV_NAME/bin/activate"

echo "If the virtual environment is not active, run:"
echo "source $VENV_NAME/bin/activate"
