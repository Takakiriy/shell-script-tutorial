#!/bin/bash

function  Main() {
    ChkConfig  "first"  ３  second  #// 動きが変
        #// 3: first-second と表示されず
        #// second: first-３ と表示されます
}

function  ChkConfig() {
    local  first="$1"
    local  number="$3"
    local  sub="$2"

    if [ "${sub}" == "" ]; then
        echo  "${number}: ${first}"
    else
        echo  "${number}: ${first}-${sub}"
    fi
}
Main  "$@"
