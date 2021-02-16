#!/usr/bin/env bash

if ! command -v stow &>/dev/null; then
    echo "'stow' could not be found, please install."
    exit 1
fi

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    -c | --config)
        config="$2"
        shift # past argument
        shift # past value
        ;;
    esac
done

# stow issue resuts in wrong warning. Can be ignored.
# https://github.com/aspiers/stow/issues/65
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    # -d stow dir
    stow -v -R -d stows -t "${usr}" "${app}"
}

get_value_of() {
    variable_name=$1
    variable_value=""
    if set | grep -q "^$variable_name="; then
        eval variable_value="\$$variable_name"
    fi
    echo "$variable_value"
}

if [ -z ${config+x} ]; then
    lines=$(./bins/python.pex src/util.py configs/stow.yml)
else
    lines=$(./bins/python_"${config}".pex src/util.py configs/stow.yml -g "${config}")
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
