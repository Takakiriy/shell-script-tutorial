#!/bin/bash

function  Return1() {
    return  1
}
function  ReturnMinus1() {
    return  -1
}

Return1
echo  $?  #// 1 と表示

ReturnMinus1
echo  $?  #// 255 と表示
