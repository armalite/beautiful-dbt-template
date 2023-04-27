#!/bin/sh

FORCE_INSTALL=0

for arg in "$@"
do
    if [[ "$arg" == "--force" ]]; then
        FORCE_INSTALL=1
    fi
done

echo "Checking OS"
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux ;;
    Darwin*)    machine=Mac ;;
    MINGW*)     machine=MinGw ;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo "User machine is running ${machine}"

install_poetry_other () {
    if [[ "$FORCE_INSTALL" -eq 1 ]]; then
        echo "Forcing Poetry installation"
        if curl -sSL https://install.python-poetry.org | python3 - --force;
        then echo "Success! Poetry has been force installed"
        else echo "Poetry force installation failed."
        fi;
    else
        if curl --fail -sSL https://install.python-poetry.org | python3 -;
        then echo "Success! Poetry has been installed"
        else echo "Poetry installation failed."
        fi;
    fi
}

install_poetry_windows () {
    if [[ "$FORCE_INSTALL" -eq 1 ]]; then
        echo "Forcing Poetry installation"
        if curl -sSL https://install.python-poetry.org | python - --force;
        then echo "Success! Poetry has been force installed"
        else echo "Poetry force installation failed."
        fi;
    else
        if curl --fail -sSL https://install.python-poetry.org | python -;
        then echo "Poetry installed"
        else echo "Poetry install failed."
        fi;
    fi
}

poetry_install () {
    if [[ "${machine}" == "MinGw" ]];
    then
        install_poetry_windows
    else
        install_poetry_other
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
    then
        if [[ "$FORCE_INSTALL" -eq 1 ]]; then
            echo "Forcing Poetry installation"
            poetry_install
        else
            echo "Poetry is already installed."
        fi
    else
        echo "Can't find poetry so installing poetry on your machine now"
        poetry_install
    fi;
}

# Check if poetry is installed, and if not, then install it
check_install

# Check if poetry has been added to PATH
check_path_set

# Set poetry to create the virtual environment in the project folder
poetry config --local virtualenvs.in-project true

echo "Installing Poetry dependencies"
poetry install

git add poetry.lock
git diff-index --quiet --cached HEAD || git commit -m "Update \`poetry.lock\`"
