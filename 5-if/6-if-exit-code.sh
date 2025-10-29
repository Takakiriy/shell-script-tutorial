#!/bin/bash

echo  "## true and false command ----------------------------"

true
echo $?

false
echo $?

if true; then
    echo  "OK"
fi
if false; then
    echo  "NG"
else
    echo  "OK"
fi

echo  "## exit code 0 is true ----------------------------"
function  IfExitCodeIs0() {
    local  variable="$1"

    if echo "${variable}"  |  grep -qE "abc"; then
        echo  "\"${variable}\" is matched with abc."
    else
        echo  "\"${variable}\" is not matched with abc."
    fi
}
IfExitCodeIs0  "abc"
IfExitCodeIs0  "def"

echo  "## exit code 0 is false ----------------------------"
function  IfExitCodeIsNot0() {
    local  variable="$1"

    if ! ( echo "${variable}"  |  grep -qE "abc" ); then
        echo  "\"${variable}\" is matched with abc."
    else
        echo  "\"${variable}\" is not matched with abc."
    fi
}
IfExitCodeIsNot0  "abc"
IfExitCodeIsNot0  "def"

echo  "## test command ----------------------------"
function  TestCommand() {
    local  variable="$1"

    if test "${variable}" == "abc"; then
        echo  "${variable} is abc."
    elif test "${variable}" != "abc"; then
        echo  "${variable} is not abc."
    fi
}
TestCommand  "abc"
TestCommand  "def"

echo  "## Do nothing ----------------------------"
function  TestDoNothing() {
    local  variable="$1"

    if echo "${variable}"  |  grep -qE "abc"; then
        :  #// DoNothing
    else
        echo  "Exit code is not 0."
    fi
}
TestDoNothing  "abc"
TestDoNothing  "def"
