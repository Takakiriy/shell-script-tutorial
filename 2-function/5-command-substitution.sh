#!/bin/bash

function  Main() {
    local  names="$( head -1 "5-command-substitution.sh" )"
    echo  "names = ${names}"

    local  names="$( head -1 "no_file.sh" )"
    echo  "names = ${names}"

    local  names="$( head -1 "$( echo "5-command-substitution.sh" )" )"
    echo  "names = ${names}"
}
Main  "$@"
