#!/bin/bash

echo  "## true false && || ----------------------------"
true   &&  echo "true &&"
false  &&  echo "false &&"
true   ||  echo "true ||"
false  ||  echo "false ||"

echo  "## stderr ----------------------------"
test  "abc" != ""  ||  echo "ERROR" >&2

cd  "."  ||  echo "ERROR" >&2
cd  "unknown_path"  ||  echo "ERROR" >&2

echo  "## Error function ----------------------------"
function  Main() {
    echo  "period"
    cd  "."  ||  Error

    echo  "unknown"
    cd  "unknown_path"  ||  Error
    echo  "Pass."
}
function  Error() {
    local  errorMessage="$1"
    if [ "${errorMessage}" == "" ]; then
        errorMessage="ERROR"
    fi

    echo  "${errorMessage}"  >&2
    exit 2
}
function  ExitIfMatched() {
    # ExitIfMatched
    #     Check function return code or function exit code in $( )
    # Example:
    #     local  out="$(x="$( command )" && echo "$x" || echo "(ERROR:$?)" )"
    #     ExitIfMatched  "${out}"  '^\(ERROR:([0-9]*)\)$'
    local  output="$1"
    local  regularExpression="$2"

    if [[ "${output}" =~ ${regularExpression} ]]; then
        local  exitCode="$( echo "${output}"  |  sed -E  's/'"${regularExpression}"'/\1/')"
        #// exit  "${exitCode}"
        echo  "exit  \"${exitCode}\""
    fi
}
out="$(x="$(  Main  )" && echo "$x" || echo "(ERROR:$?)" )"
ExitIfMatched  "${out}"  '^\(ERROR:([0-9]*)\)$'

echo  "## if && || ----------------------------"
function  IfAndOr() {
    local  variableA="$1"
    local  variableB="$2"

    if [ "${variableA}" == "abc" ] && [ "${variableB}" == "def" ]; then
        echo  "${variableA} ${variableB}: && true"
    else
        echo  "${variableA} ${variableB}: && false"
    fi

    if [ "${variableA}" == "abc" ] || [ "${variableB}" == "def" ]; then
        echo  "${variableA} ${variableB}: || true"
    else
        echo  "${variableA} ${variableB}: || false"
    fi
}
IfAndOr  "abc"  "def"
IfAndOr  "abc"  "456"
IfAndOr  "123"  "def"
IfAndOr  "123"  "456"

echo  "## if -a -o ----------------------------"
function  IfAndOrH() {
    local  variableA="$1"
    local  variableB="$2"

    if [ "${variableA}" == "abc"  -a  "${variableB}" == "def" ]; then
        echo  "${variableA} ${variableB}: && true"
    else
        echo  "${variableA} ${variableB}: && false"
    fi

    if [ "${variableA}" == "abc"  -o  "${variableB}" == "def" ]; then
        echo  "${variableA} ${variableB}: || true"
    else
        echo  "${variableA} ${variableB}: || false"
    fi
}
IfAndOrH  "abc"  "def"
IfAndOrH  "abc"  "456"
IfAndOrH  "123"  "def"
IfAndOrH  "123"  "456"

echo  "## if [[ && || ]] ----------------------------"
function  IfAndOrD() {
    local  variableA="$1"
    local  variableB="$2"

    if [[ "${variableA}" == "abc"  &&  "${variableB}" == "def" ]]; then
        echo  "${variableA} ${variableB}: && true"
    else
        echo  "${variableA} ${variableB}: && false"
    fi

    if [[ "${variableA}" == "abc"  ||  "${variableB}" == "def" ]]; then
        echo  "${variableA} ${variableB}: || true"
    else
        echo  "${variableA} ${variableB}: || false"
    fi
}
IfAndOrD  "abc"  "def"
IfAndOrD  "abc"  "456"
IfAndOrD  "123"  "def"
IfAndOrD  "123"  "456"

# VarA="alpha"
# VarB="beta"
# if [ "${VarA}" == "alpha" ] && [ "${VarB}" == "beta" ]; then
#     echo  "Alpha and Beta."
# else
#     echo  "others"
# fi
# 
# VarA="alpha"
# VarB="----"
# if [ "${VarA}" == "alpha" ] && [ "${VarB}" == "beta" ]; then
#     echo  "Alpha and Beta."
# else
#     echo  "others"
# fi
# 
# VarA="----"
# VarB="beta"
# if [ "${VarA}" == "alpha" ] && [ "${VarB}" == "beta" ]; then
#     echo  "Alpha and Beta."
# else
#     echo  "others"
# fi
