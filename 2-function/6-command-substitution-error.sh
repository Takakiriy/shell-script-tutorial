#!/bin/bash

if [ "$1" == "" ]; then
    ReturnCode=0
else
    ReturnCode=1
fi

function  Main() {

    local  variable="$( CommandExample  ||  echo "(ERROR)" )"
    echo  "variable = \"${variable}\""
    ErrorIfLastIs  "${variable}"  "(ERROR)"
    echo  "Done."
}

function  CommandExample() {
    echo  "output example"
    return  ${ReturnCode}  #// 0 or 1
}

function  ErrorIfLastIs() {
    local  output="$1"
    local  tag="$2"

    local  last="${output:${#output}-${#tag}:${#tag}}"

    if [ "${last}" == "${tag}" ]; then
        exit  2
    fi
}
Main  "$@"
