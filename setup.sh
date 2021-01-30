#!/usr/bin/env bash

if ! command -v stow &> /dev/null
then
    echo "stow could not be found, please install."
    exit
fi

# stow issue resuts in wrong warning. Can be ignored.
# https://github.com/aspiers/stow/issues/65
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t "${usr}" "${app}"
}

applyit() {
    declare -a list=("${!1}")
    for tuple in "${list[@]}"; do
	    path=$(echo "$tuple" | cut -d";" -f1)
	    app=$(echo "$tuple" | cut -d";" -f2)

	    echo "Linking to $path"
	    mkdir -p "$path"
	    stowit "$path" "$app"
    done
}

base=(
    "$HOME/.autoload;autoload"
    "$HOME/.config/nvim;nvim"
    "$HOME;tmux"
    "$HOME/.tmuxinator;tmuxinator"
)

mac=(
    "$HOME;mac__zprezto"
)

echo ""
echo "Stowing base"
echo ""

# pass base as name, it will be expanded in function applyit
applyit base[@]

echo ""
echo "Stowing mac"
echo ""
if [[ "$OSTYPE" == "darwin"* ]]; then
    applyit mac[@]
fi

echo "All done"

