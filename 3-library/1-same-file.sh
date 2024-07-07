#!/bin/bash

function  Main() {
    Sub
}

function  Sub() {
    echo  "Sub!"
}
Main  "$@"
