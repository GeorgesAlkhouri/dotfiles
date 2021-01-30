#!/usr/bin/env bash

if ! command -v stow &>/dev/null; then
    echo "stow could not be found, please install."
    exit
fi

# If linux OS need to know which config to use.
if [[ "$OSTYPE" == "linux"* ]]; then
    case "$1" in
    linux) config=linux ;;

    linux__uberspace) config=linux__uberspace ;;

    *)
        echo "Linux config not set. Choices linux | linux__ubersapce"
        exit 1
        ;;
    esac
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

linux_uberspace=(
    "$HOME;linux__uberspace_zprezto"
)

echo ""
echo "Stowing base"
echo ""

# pass base as name, it will be expanded in function applyit
applyit base[@]

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo ""
    echo "Stowing for mac"
    echo ""
    applyit mac[@]
elif [[ "$OSTYPE" == "linux"* ]]; then
    echo ""
    echo "Stowing for linux"
    echo ""
    applyit $config[@]
fi

echo "All done"
