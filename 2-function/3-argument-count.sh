#!/bin/bash

function  Main() {
    ChkConfig  "first"  second  3
}

function  ChkConfig() {
    echo  $#
    echo  "$#"
}
Main  "$@"
