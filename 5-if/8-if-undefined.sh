#!/usr/bin/env bash

if [ "${Case}" == "" ]; then
    Case=11
fi

if (( ${Case} == 11 )); then
    echo  "## undefined value is empty string ----------------------------"
    if [[ "${unsetVariable}" == "" ]]; then  #// 未定義の場合、空文字列
        echo  "undefined!"
    fi
fi

if (( ${Case} == 12 )); then
    echo  "## undef number ----------------------------"

    if (( undefVariable1 == 0 )); then
        echo  "undefVariable1 is 0."
    else
        echo  "undefVariable1 is not 0."
    fi

    if (( ${undefVariable2} == 0 )); then
        echo  "undefVariable2 is 0."
    else
        echo  "undefVariable2 is not 0."
    fi

    if (( "${undefVariable3}" == 0 )); then
        echo  "\"undefVariable3\" is 0."
    else
        echo  "\"undefVariable3\" is not 0."
    fi
fi


set -u

if (( ${Case} == 16 )); then
    echo  "## set -u undefined variable ----------------------------"
    if [[ "${unsetVariable}" == "" ]]; then  #// 未定義の場合、空文字列
        echo  "undefined!"
    fi
fi

function  Case21() {
    local  argument1="$1"
}
if (( ${Case} == 21 )); then
    echo  "## default argument error ----------------------------"
    Case21
fi

function  Case22() {
    local  target="$1"
    local  option="${2-""}"  #// "${1-""}" means that "$1" default is "".  #// デフォルト引数。 コメントを書くこと。 $1 を $2 に変える必要はありません

    echo  "(${target})"
    echo  "(${option})"
}
if (( ${Case} == 22 )); then
    echo  "## default argument ----------------------------"
    Case22  "abc"
    Case22  "abc"  "def"
fi

if (( ${Case} == 31 )); then
    echo  "## array ----------------------------"
    Array1=( "Item0" "Item1" )
    if [[ "${Array1[10]}" == "" ]]; then  #// 配列番号が大きすぎる場合、空文字列
        echo  "empty string from Array1"
    fi
fi
if (( ${Case} == 32 )); then
    echo  "## associative array ----------------------------"
    echo "BASH_VERSION: ${BASH_VERSION}"
    declare -A  Dictionary1=()
    Dictionary1["attr1"]="Value1"
    Dictionary1["attr2"]="Value2"
    if [[ "${Dictionary1["Unknown"]}" == "" ]]; then  #// 連想配列にないキーの場合、空文字列
        echo  "empty string from Dictionary1"
    fi
fi
