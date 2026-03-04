#!/bin/bash

PositionalArgs=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--message) Options_Message="$2"; shift; shift;;
        -t|--target)  Options_Target="$2"; shift; shift;;
        --search-path)  Options_SearchPath="$2"; shift; shift;;
        --watch)  Options_Watch="true"; shift;;
        -v|--verbose)  Options_Verbose="true"; shift;;
        --) shift;  PositionalArgs+=("$@"); set --;;
        -*) echo "ERROR: Unknown option $1"; exit 1;;
        *)  PositionalArgs+=("$1"); shift;;
    esac
done
set -- "${PositionalArgs[@]}"  #// set $1, $2, ...
unset PositionalArgs

set -u
#// Set default values. "! -v" means that variable is not defined.
if ! [[ -v Options_Message ]]; then  Options_Message=""  ;fi
if ! [[ -v Options_Target ]]; then  Options_Target="local"  ;fi
if ! [[ -v Options_SearchPath ]]; then  Options_SearchPath=""  ;fi
if ! [[ -v Options_Watch ]]; then  Options_Watch="false"  ;fi
if ! [[ -v Options_Verbose ]]; then  Options_Verbose="false"  ;fi

echo  ""
echo  "6-option/3-delegate.sh"
echo  "\$Options_Message = \"${Options_Message}\""
echo  "\$Options_Target = \"${Options_Target}\""
echo  "\$Options_SearchPath = \"${Options_SearchPath}\""
echo  "\$Options_Watch = \"${Options_Watch}\""
echo  "\$Options_Verbose = \"${Options_Verbose}\""
if [[ -v 1 ]]; then
    echo  "\$1 = \"$1\""
else
    echo  "\$1 = \"\""
fi
if [[ -v 2 ]]; then
    echo  "\$2 = \"$2\""
else
    echo  "\$2 = \"\""
fi
echo  ""

function  Main() {

    local  options=()
    AddOptionToArray  options  "--message"  "${Options_Message}"
    AddOptionToArray  options  "--target"  "${Options_Target}"  --default "local"
    # AddOptionToArray  options  "--search-path"  "${Options_SearchPath}"  --always
    AddOptionToArray  options  "--watch"  "${Options_Watch}"  --flag
    AddOptionToArray  options  "--verbose"  "${Options_Verbose}"  --flag

    echo_q  "${options[@]}"  "$@"
}

function  AddOptionToArray() {
    #// Example:
    #//     local  options=()
    #//     AddOptionToArray  options  "--test"  "${Options_Test}"
    #//     AddOptionToArray  options  "--message"  "${Options_Message}"  --default "no message"
    #//     AddOptionToArray  options  "--search-path"  "${Options_SearchPath}"  --always
    #//     AddOptionToArray  options  "--verbose"  "${Options_Verbose}"  --flag
    #//     sub_script.sh  "${options[@]}"
    local -n  arrayRef=$1  #// nameref (Bash 4.3+)
    local  optionName="$2"
    local  value="$3"
    local  thisOption="${4-""}"  #// "", "--flag" or "--default".  "${1-""}" means that "$1" default is "".
    local  default="${5-""}"  #// "${1-""}" means that "$1" default is "".
    if [ "${thisOption}" != "--default" ]; then
        default=""
    fi

    if [ "${thisOption}" == "--flag" ]; then
        if [ "${value}" != "" ] && [ "${value}" != "false" ] && [ "${value}" != "no" ]; then
            arrayRef+=("${optionName}")
        #// else no add
        fi
    elif [ "${thisOption}" == "--always" ]; then
        arrayRef+=("${optionName}" "${value}")
    else
        if [ "${value}" != "${default}" ]; then
            arrayRef+=("${optionName}" "${value}")
        #// else no add
        fi
    fi
}

function  echo_q() {
    local  output="'./echo-q'"
    local  parameter=""

    for parameter in "$@"; do
        output="${output}  '${parameter}'"
    done
    echo  "${output}"
}

Main  "$@"
