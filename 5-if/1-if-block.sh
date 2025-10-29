#!/bin/bash

echo  "## 基本 if のみ ----------------------------"
Variable="abc"
if [ "${Variable}" == "abc" ]; then
    echo  "value is abc."
fi

echo  "## if と elif (else if) と else ----------------------------"
function  IfElse() {
    local  variable="$1"

    if [ "${variable}" == "abc" ]; then
        echo  "value is abc."
    elif [ "${variable}" == "def" ]; then
        echo  "value is def."
    else
        echo  "else"
    fi
}
IfElse  "abc"
IfElse  "def"
IfElse  "g"
