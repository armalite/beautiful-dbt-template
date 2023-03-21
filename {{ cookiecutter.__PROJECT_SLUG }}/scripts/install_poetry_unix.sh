#!/bin/bash

echo "Please enter the remote Git URL:"
read REMOTE_URL

# Detect the OS and WSL2
OS=$(uname -s)
WSL2=false
if [[ "$OS" == "Linux" ]] && grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
  WSL2=true
fi

# Install Poetry
if ! command -v poetry &> /dev/null; then
  curl -sSL https://install.python-poetry.org | python3 -
  if [[ "$OS" == "Darwin" ]]; then
    export PATH=$HOME/Library/Python/3.9/bin:$PATH
  elif [[ "$OS" == "Linux" ]]; then
    export PATH=$HOME/.local/bin:$PATH
  fi
fi

# Set poetry to create the virtual environment in the project folder
poetry config --local virtualenvs.in-project true

# Apply updates to poetry lock file
poetry update

echo "Installing Poetry dependencies"
poetry install

# Initialize git repo, commit, and push to remote
git init
git add .
git commit -m "Initialise Beautiful DBT Template"
git remote add origin $REMOTE_URL
git push -u origin master

echo "Installation complete. Activate the virtual environment with 'poetry shell' or run any command preceded with 'poetry run'."

