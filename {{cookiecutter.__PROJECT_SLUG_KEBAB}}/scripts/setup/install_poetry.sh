#!/bin/sh

echo "Checking OS"
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux ;;
    Darwin*)    machine=Mac ;;
    MINGW*)     machine=MinGw ;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "User machine is running ${machine}"

poetry_install () {
    if curl --fail -sSL https://install.python-poetry.org | python3 -;
    then echo "Success! Poetry has been installed"
    else echo "Poetry installation failed."
    fi;
}

check_path_set () {
    echo "Checking poetry is located in PATH"
    if command -v poetry &> /dev/null;
    then echo "Poetry in path";
    else
        echo "Poetry not in path. If this is your first time installing Poetry, please restart your terminal"
        exit 0
    fi;
}

check_install () {
    echo "Checking if you have poetry on your machine"
    if command -v poetry &> /dev/null;
    then echo "Poetry is already installed.";
    else echo "Can't find poetry so installing poetry on your machine now"
        poetry_install
    fi;
}

# Check if poetry is installed, and if not, then install it
check_install

# Check if poetry has been added to PATH
check_path_set

# Set poetry to create the virtual environment in the project folder
poetry config --local virtualenvs.in-project true

# Apply updates to poetry lock file
poetry update

echo "Installing Poetry dependencies"
poetry install
