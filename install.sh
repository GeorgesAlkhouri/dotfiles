#!/usr/bin/env bash

if ! command -v stow &> /dev/null
then
    echo "stow could not be found, please install."
    exit
fi

stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t "${usr}" "${app}"
}

base=(
    "$HOME/.config/nvim;nvim"
    "$HOME/.tmuxinator;tmuxinator"
)

echo ""

for tuple in "${base[@]}"; do
    path=$(echo "$tuple" | cut -d";" -f1)
    app=$(echo "$tuple" | cut -d";" -f2)

    echo "Linking to $path"
    mkdir -p "$path"
    stowit "$path" "$app"
done

echo "All done"

