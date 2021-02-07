#!/usr/bin/env bash

if ! command -v stow &>/dev/null; then
    echo "'stow' could not be found, please install."
    exit 1
fi

# check python requirements
# grep should return 2
found_deps=$(pip --disable-pip-version-check list | grep -cw "click\|PyYAML")

if [ "$found_deps" -lt "2" ]; then
    echo "Not all needed python deps where found."
    exit 1
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

get_value_of() {
    variable_name=$1
    variable_value=""
    if set | grep -q "^$variable_name="; then
        eval variable_value="\$$variable_name"
    fi
    echo "$variable_value"
}

if [ $# -eq "0" ]; then
    lines=$(python util.py configs/stow.yml)
else
    lines=$(python util.py configs/stow.yml "$@")
fi

SAVEIFS=$IFS       # Save current IFS
IFS=$'\n'          # Change IFS to new line
configs=("$lines") # split to array 
IFS=$SAVEIFS

echo "---------------------------------------------"
for tuple in ${configs[@]}; do
    path=$(echo "$tuple" | cut -d";" -f1)
    app=$(echo "$tuple" | cut -d";" -f2)

    echo "Linking to $path"
    mkdir -p "$path"
    stowit "$path" "$app"
    echo "---------------------------------------------"
done
echo
echo "All done"
