#!/bin/bash

function  Main() {
    local  result="$( ChkConfig )"
}

function  ChkConfig() {
    echo  "output example"
    echo  "ERROR"  >&2
}

Main  "$@"
