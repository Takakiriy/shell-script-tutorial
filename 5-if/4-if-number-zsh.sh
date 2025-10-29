#!/bin/zsh

echo "BASH_VERSION: ${BASH_VERSION}"
echo "ZSH_VERSION: ${ZSH_VERSION}"

echo  "## ==, != ----------------------------"
function  IfInteger() {
    local  variable="$1"

    if (( "${variable}" == 10 )); then
        echo  "${variable} is 10."
    elif (( ${variable} == 11 )); then  #// " " で囲まなくても動きます
        echo  "${variable} is 11."
    elif (( variable == 12 )); then  #// (( )) の中は "${ }" で囲まなくても動きますが、書き方に統一性がありません
        echo  "${variable} is 12."
    elif (( "${variable}" != 10 )); then
        echo  "${variable} is not 10."
    fi
}
IfInteger  "10"
IfInteger  " 11"
IfInteger  12
IfInteger  13
if (( not_defined == 0 )); then
    echo  "\"${not_defined}\" is not defined but 0."
fi
if (( "${not_defined}" == 0 )); then
    echo  "\"${not_defined}\" is available."
else
    echo  "\"${not_defined}\" is not available."
fi

echo  "## -eq, -ne ----------------------------"
function  IfIntegerO() {
    local  variable="$1"

    if [ "${variable}" -eq 10 ]; then
        echo  "${variable} is 10."
    elif [ "${variable}" -eq 11 ]; then
        echo  "${variable} is 11."
    elif [ "${variable}" -ne 10 ]; then
        echo  "${variable} is not 10."
    fi
}
IfIntegerO  "10"
IfIntegerO  " 11"
IfIntegerO  "12"
if (( 5 -eq 5 )); then  #// Error. Use == insted of -eq
    echo  "-eq option is available."
fi
if (( not_defined -eq 0 )); then
    echo  "\"${not_defined}\" is not defined."
fi

echo  "## = ----------------------------"
function  IfIntegerSingleEqual() {
    local  variable="$1"

    if (( "${variable}" = 5 )); then  #// 代入して 0 を返します。つまり、5と比較していません
        echo  "${variable} is 5."
    elif (( variable = 5 )); then  #// 代入して 0 を返します。つまり、5と比較していません
        echo  "${variable} is 5."
    else
        echo  "${variable} is not 5."
    fi
}
IfIntegerSingleEqual  5
IfIntegerSingleEqual  6

echo  "## <, >, >=, <= ----------------------------"
function  IfIntegerLessGrater() {
    local  variable="$1"
    local  abc=4

    if (( "${variable}" < 3 )); then  #// 2重カッコであることに注意
        echo  "${variable} is less than 3."
    elif (( "${variable}" <= 3 )); then  #// 2重カッコであることに注意
        echo  "${variable} is less equal 3."
    elif (( "${variable}" < "5" )); then  #// 2重カッコであることに注意
        echo  "${variable} is less than 5."
    elif (( "${variable}" > 7 )); then  #// 2重カッコであることに注意。<> は書けません
        echo  "${variable} is greater than 7."
    elif (( "${variable}" >= 7 )); then  #// 2重カッコであることに注意
        echo  "${variable} is greater equal 7."
    elif (( variable > "5" )); then  #// 2重カッコであることに注意。 変数を "${ }" で囲まなくても動きます
        echo  "${variable} is greater than 5."
    else
        echo  "${variable} is in else"
    fi
}
IfIntegerLessGrater  2
IfIntegerLessGrater  "3"
IfIntegerLessGrater  7
IfIntegerLessGrater  10
IfIntegerLessGrater  "6"
IfIntegerLessGrater  5
IfIntegerLessGrater  "abc"  #// (( )) の中では abc 変数の値になります
IfIntegerLessGrater  ""

echo  "## -lt, -gt, -le, -lt ----------------------------"
function  IfIntegerLessGraterO() {
    local  variable="$1"
    local  abc=4

    if (( "${variable}" -lt 3 )); then  #// 2重カッコであることに注意
        echo  "${variable} is less than 3."
    elif (( "${variable}" -le 3 )); then  #// 2重カッコであることに注意
        echo  "${variable} is less equal 3."
    elif (( "${variable}" -lt "5" )); then  #// 2重カッコであることに注意
        echo  "${variable} is less than 5."
    elif (( "${variable}" -gt 7 )); then  #// 2重カッコであることに注意。<> は書けません
        echo  "${variable} is greater than 7."
    elif (( "${variable}" -ge 7 )); then  #// 2重カッコであることに注意
        echo  "${variable} is greater equal 7."
    elif (( variable -gt "5" )); then  #// 2重カッコであることに注意。 変数を "${ }" で囲まなくても動きます
        echo  "${variable} is greater than 5."
    else
        echo  "${variable} is in else"
    fi
}
IfIntegerLessGraterO  2
IfIntegerLessGraterO  "3"
IfIntegerLessGraterO  7
IfIntegerLessGraterO  8
IfIntegerLessGraterO  "6"
IfIntegerLessGraterO  5
IfIntegerLessGraterO  "abc"  #// (( )) の中では abc 変数の値になります
IfIntegerLessGraterO  ""

echo  "## calcurate and compare ----------------------------"
function  IfCalcurateAndCompare() {
    local  variable="$1"
    local  abc=4

    if (( "${variable}" + 2 == 4 )); then  #// 2重カッコであることに注意
        echo  "${variable} + 2 == 4"
    elif (( "${variable}" + 2 == 5  )); then  #// 2重カッコであることに注意
        echo  "${variable} + 2 == 5"
    elif (( "${variable}" - 4 == 0 )); then  #// 2重カッコであることに注意
        echo  "${variable} - 4 == 0"
    elif (( "${variable}" * 2 == 10 )); then  #// 2重カッコであることに注意
        echo  "${variable} * 2  == 10"
    elif (( "${variable}" / 3 == 2 )); then  #// 2重カッコであることに注意
        echo  "${variable} / 3  == 2"
    elif (( "${variable}" / 3 == 3 )); then  #// 2重カッコであることに注意
        echo  "${variable} / 3  == 3 (not 3.333...)"
    elif (( "${variable}" / 4.0 == 3.5 )); then  #// 2重カッコであることに注意。小数点があれば浮動小数
        echo  "${variable} / 4.0 == 3.5"
    elif (( "${variable}" + 1 * 2 == 3 )); then  #// 2重カッコであることに注意
        echo  "${variable} + 1 * 2 == 3"
    elif (( ( "${variable}" + 1 ) * 2 == 0 )); then  #// 2重カッコであることに注意
        echo  "( ${variable} + 1 ) * 2 == 0"
    else
        echo  "${variable} is in else"
    fi
}
IfCalcurateAndCompare  2
IfCalcurateAndCompare  3
IfCalcurateAndCompare  4
IfCalcurateAndCompare  5
IfCalcurateAndCompare  6
IfCalcurateAndCompare  10
IfCalcurateAndCompare  14
IfCalcurateAndCompare  1
IfCalcurateAndCompare  -1
