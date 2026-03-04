PositionalArgs=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--search-path)  Options_SearchPath="$2"; shift; shift;;
        -m|--message) Options_Message="$2"; shift; shift;;
        --target)  Options_Target="$2"; shift; shift;;
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
if ! [[ -v Options_SearchPath ]]; then  Options_SearchPath=""  ;fi
if ! [[ -v Options_Message ]]; then  Options_Message=""  ;fi
if ! [[ -v Options_Target ]]; then  Options_Target=""  ;fi
if ! [[ -v Options_Watch ]]; then  Options_Watch="false"  ;fi
if ! [[ -v Options_Verbose ]]; then  Options_Verbose="false"  ;fi

echo  ""
echo  "5-option/3-delegate.sh"
echo  "\$Options_SearchPath = \"${Options_SearchPath}\""
echo  "\$Options_Message = \"${Options_Message}\""
echo  "\$Options_Target = \"${Options_Target}\""
echo  "\$Options_Watch = \"${Options_Watch}\""
echo  "\$Options_Verbose = \"${Options_Verbose}\""
echo  "\$1 = \"$1\""
echo  "\$2 = \"$2\""
echo  ""

function  Main() {
    local  options=()
    AddOptionToArray  options  "--search-path"  "${Options_SearchPath}"
    AddOptionToArray  options  "--message"  "${Options_Message}"
    AddOptionToArray  options  "--target"  "${Options_Target}"
    AddOptionToArray  options  "--watch"  "${Options_Watch}"  --flag
    AddOptionToArray  options  "--verbose"  "${Options_Verbose}"  --flag

    ./2-parse-e.sh  "${options[@]}"
}

function  AddOptionToArray() {
    #// Example:
    #//     local  options=()
    #//     AddOptionToArray  options  "--test"  "${Options_Test}"
    #//     AddOptionToArray  options  "--verbose"  "${Options_Verbose}"  --flag
    #//     sub_script.sh  "${options[@]}"
    local -n  arrayRef=$1  #// nameref (Bash 4.3+)
    local  optionName="$2"
    local  value="$3"
    local  type="${4-""}"  #// "" or "--flag".  "${1-""}" means that "$1" default is "".

    if [ "${type}" == "--flag" ]; then
        if [ "${value}" != "" ] && [ "${value}" != "false" ] && [ "${value}" != "no" ]; then
            arrayRef+=("${optionName}")
        #// else no add
        fi
    else
        if [ "${value}" != "" ]; then
            arrayRef+=("${optionName}" "${value}")
        #// else no add
        fi
    fi
}

Main  "$@"
