#!/bin/bash
if echo "$0" | grep "/" | grep -E -v "bash-debug|systemd" > /dev/null; then  cd "${0%/*}"  ;fi  # cd this file folder

source  "function.sh"

function  Main() {
    Sub
}
Main  "$@"
