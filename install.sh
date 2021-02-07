#!/usr/bin/env bash

if ! command -v curl &>/dev/null; then
    echo "Please install curl."
    exit 1
fi

if [[ "$OSTYPE" == "darwin"* ]]; then

    if ! command -v xode-select &>/dev/null; then
        echo "Installing XCode Utils"
        sudo xcode-select --install
    fi
fi

#elif [[ "$OSTYPE" == "linux"* ]]; then
echo "Installing Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install -q --HEAD neovim
brew install -q pyenv fzf ripgrep \
    git \
    git-flow \
    tldr \
    tmux \
    zsh \
    npm \
    shellcheck \
    shfmt \
    tmuxinator

## brew post install
eval "$(command pyenv init -)"

npm install -g prettier jsonlint

# Python

PY_VER=3.8.6

git clone https://github.com/pyenv/pyenv-virtualenv.git "$(pyenv root)"/plugins/pyenv-virtualenv
eval "$(command pyenv virtualenv-init -)"

pyenv virtuelenv "$PY_VER" pynvim
pyenv activate pynvim
pip install flake8 pylint yapf isort mypy vim-vint yamllint pynvim python-language-server
pyenv deactivate

pyenv virtuelenv "$PY_VER" sys
pip install flake8 pylint yapf isort mypy
pyenv deactivate


# Neovim

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Plugins
nvim +PlugInstall +qall

