PositionalArgs=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--search-path)  Options_SearchPath="$2"; shift; shift;;
        -m|--message) Options_Message="$2"; shift; shift;;
        --target)  Options_Target="$2"; shift; shift;;
        ---watchg)  Options_Watch="true"; shift;;
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
echo  "5-option/2-parse-e.sh"
echo  "\$Options_SearchPath = \"${Options_SearchPath}\""
echo  "\$Options_Message = \"${Options_Message}\""
echo  "\$Options_Target = \"${Options_Target}\""
echo  "\$Options_Watch = \"${Options_Watch}\""
echo  "\$Options_Verbose = \"${Options_Verbose}\""
echo  "\$1 = \"$1\""
echo  "\$2 = \"$2\""
