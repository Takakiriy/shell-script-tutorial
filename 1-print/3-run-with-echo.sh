#!/bin/bash

function  Main() {

    echo  "$ ChkConfig  \"first\"  second  3"
    ChkConfig  "first"  second  3

    echo  "----"

    RunWithEcho  ChkConfig  "first"  second  3
        #// cd  "____/shell-script-tutorial/1-print"
        #// $ ChkConfig  first  second  3
        #// 3: first-second
        #// と表示されます
}

function  RunWithEcho() {
    echo  "$ cd  \"${PWD}\""
    echo  "$ $( GetArgumentsString  "$@" )"  >&2
    "$@"
}

function  GetArgumentsString() {
    local  arguments=""
    until [ "$1" == "" ]; do
        if [ "${1:0:1}" == "-" ]; then
            arguments="${arguments} $1"
        elif [ "$( echo "$1" | sed -E 's- |\.|/--' )" != "$1" ]; then  #// has space, period or slash
            arguments="${arguments} \"$1\""
        else
            arguments="${arguments} $1"
        fi
        shift
    done

    echo  "${arguments:1}"
}

function  ChkConfig() {
    local  first="$1"
    local  sub="$2"  #// ここに引数の補足説明を書く
    local  number="$3"

    if [ "${sub}" == "" ]; then
        echo  "${number}: ${first}"
    else
        echo  "${number}: ${first}-${sub}"
    fi
}

Main  "$@"
