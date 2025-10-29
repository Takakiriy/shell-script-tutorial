#!/bin/bash

echo  "## stdout string ----------------------------"
function  IfStdOutString() {
    local  variable="$1"

    if [ "$( echo "${variable}" )" == "abc" ]; then
        echo  "Output \"${variable}\" is abc."
    elif [ "$( echo "${variable}" )" != "abc" ]; then
        echo  "Output \"${variable}\" is not abc."
    fi
}
IfStdOutString  "abc"
IfStdOutString  "def"


echo  "## stdout number ----------------------------"
function  IfStdOutNumber() {
    local  variable="$1"

    if (( "$( echo "${variable}" )" < 5 )); then
        echo  "Output \"${variable}\" is less than 5."
    else
        echo  "Output \"${variable}\" is not less than 5."
    fi
}
IfStdOutNumber  4
IfStdOutNumber  5
