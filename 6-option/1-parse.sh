#!/bin/bash

PositionalArgs=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -m|--message) Options_Message="$2"; shift; shift;;
        -t|--target)  Options_Target="$2"; shift; shift;;
        --search-path)  Options_SearchPath="$2"; shift; shift;;
        --watch)  Options_Watch="yes"; shift;;
        -v|--verbose)  Options_Verbose="yes"; shift;;
        --) shift;  PositionalArgs+=("$@"); set --;;
        -*) echo "ERROR: Unknown option $1"; exit 1;;
        *)  PositionalArgs+=("$1"); shift;;
    esac
done
set -- "${PositionalArgs[@]}"  #// set $1, $2, ...
unset PositionalArgs

echo  ""
echo  "6-option/1-parse.sh"
echo  "\$Options_Message = \"${Options_Message}\""
echo  "\$Options_Target = \"${Options_Target}\""
echo  "\$Options_SearchPath = \"${Options_SearchPath}\""
echo  "\$Options_Watch = \"${Options_Watch}\""
echo  "\$Options_Verbose = \"${Options_Verbose}\""
echo  "\$1 = \"$1\""
echo  "\$2 = \"$2\""
