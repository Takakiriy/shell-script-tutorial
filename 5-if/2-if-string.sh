#!/bin/bash

echo  "## ==, != ----------------------------"
function  IfString() {
    local  variable="$1"

    if [ "${variable}" == "abc" ]; then
        echo  "${variable} is abc."
    elif [ "${variable}" != "abc" ]; then
        echo  "${variable} is not abc."
    fi
}
IfString  "abc"
IfString  "def"

echo  "## = ----------------------------"
function  IfStringSingleEqual() {
    local  variable="$1"

    if [ "${variable}" = "abc" ]; then
        echo  "${variable} is abc."
    else
        echo  "${variable} is not abc."
    fi
}
IfStringSingleEqual  "abc"
IfStringSingleEqual  "def"

echo  "## <, > ----------------------------"
function  IfStringLessGrater() {
    local  variable="$1"

    if [[ "${variable}" < "abc" ]]; then  #// 2重カッコであることに注意。<= は書けません
        echo  "${variable} is less than abc."
    elif [[ "${variable}" > "abc" ]]; then  #// 2重カッコであることに注意。>= は書けません
        echo  "${variable} is greater than abc."
    else
        echo  "${variable} is abc."
    fi
}
IfStringLessGrater  "abb"
IfStringLessGrater  "abc"
IfStringLessGrater  "abcc"

echo  "## >=, <=, -eq, -ne ----------------------------"
function  IfStringError() {
    local  variable="$1"
    local  abc="5"

    #// Select comment out or not in the following if statement.
    # if [ "${variable}" <= "abc" ]; then
    # if [ "${variable}" >= "abc" ]; then
    if [ "${variable}" -eq abc ]; then
    # if [ "${variable}" -ne "abc" ]; then
    # if [ "${variable}" -le "abc" ]; then
    # if [ "${variable}" -gt "abc" ]; then
        echo  "true"
    else
        echo  "false"
    fi
}
IfStringError  "a"
IfStringError  "5"

echo  "## =~ ---------------------------------==="
function  EqualTilde() {
    local  variable="$1"

    if [[ "${variable}" =~ "a.c" ]]; then  #// =~ operator is faster than grep command.
        echo  "${variable} is matched with \"a.c\"."
    elif ! [[ ${variable} =~ "a.c" ]]; then  #// =~ operator is faster than grep command.
        echo  "${variable} is not matched with \"a.c\"."
    fi
}
EqualTilde  "abc"
EqualTilde  "ABC"


echo end
