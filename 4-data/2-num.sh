#!/bin/bash

echo  $(( 2 + 3 ))  #// 5
echo  $(( 7 / 2 ))  #// 3
echo  $(( 1 + 2 * 3 ))  #// 7

a=2
echo  $(( a + 1 ))     #// 3
echo  $(( ${a} + 1 ))  #// 3
echo  $(( $a + 1 ))    #// 3

result=$(( a + 2 ))
echo  "${result}"

echo  "## a += b ----------------------------"
a=2
(( b = 3 ))   #// We can write spaces.
(( a += b ))  #// If $(( num += 3 )) then error of "5: command not found".
echo  "${a}"  #// 5


echo  "## local ----------------------------"
function  CalcA() {
    local  num=2
    local  result=$(( num + 3 * 2 ))
    local  result2

    (( result2 = num + 3 * 2 ))
        #// 以下のように書けません:
        #//    (( local result2 = num + 3 * 2 ))
        #//    local (( result2 = num + 3 * 2 ))
    echo  "${num}"  #// 2
    echo  "${result}"  #// 8
    echo  "${result2}"  #// 8
}
num=0
result=11
result2=22

CalcA
echo  "${num}"  #// 0 ... Not overwritten by local variable in function
echo  "${result}"  #// 11
echo  "${result2}"  #// 22


echo  "## float ----------------------------"

echo  "scale=3;  5 / 3"  |  bc   #// 1.666
echo  "5 / 3"            |  bc   #// 1 になってしまう
Result=$( echo  "scale=3;  5 / 3"  |  bc )
echo  "${Result}"
