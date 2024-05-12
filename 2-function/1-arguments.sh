#!/bin/bash

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

ChkConfig  "first"  second  3
ChkConfig  "first"  ""  3
