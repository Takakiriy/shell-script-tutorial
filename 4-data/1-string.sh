#!/bin/bash

echo  "## 結合 ----------------------------"
Result="OK"

"結果: ${Result}"

echo  "## 複数行の文字列 ----------------------------"
echo  "### 基本 ----------------------------"

Lines=\
"Line1
Line2
Line3"

echo  "${Lines}"

echo  "### 関数内 ----------------------------"
function  SetLines() {

    local  lines="Line1
        Line2
        Line3"

    echo  "${lines}"
}
SetLines

echo  "### ヒア ドキュメント ----------------------------"

Lines="..."  #// This value will be overwritten
    read -r -d '' Lines <<- __HERE_DOCUMENT__
        zone "vmlocal.com" IN {
            ...
        }
__HERE_DOCUMENT__
    Lines="$( echo "${Lines}"  |  sed -E 's/^ {8}//' )"  #// Cut space indent

echo  "${Lines}"

echo  "### ファイル出力 ----------------------------"
function  WriteLines() {

    echo  "Line1"  >  "_text.txt"
    echo  "Line2"  >> "_text.txt"
    echo  "Line3"  >> "_text.txt"
}
rm  "_text.txt"
WriteLines
cat "_text.txt"
rm  "_text.txt"

echo  "### 変数代入 ----------------------------"
function  LinesVariable() {
    local  LF=$'\n'

    local  lines="Line1${LF}"
    lines="${lines}Line2${LF}"
    lines="${lines}Line3"
    #// 最終行に ${LF} を入れると、echo 表示したときの最終行に空行が出力されてしまうので注意

    echo  "${lines}"
}
LinesVariable

echo  "## 文字列の一部 ----------------------------"
echo  "### インデックス指定 ----------------------------"
function  IndexSubString() {
    local  variable="ABCDE"

    echo ${variable:2:2}      #// ${__VAR__:__Start__:__Second__} は、__Start__+1 文字目から __Second__ 文字（文字数）
        #// CD                #// zsh の場合、$VAR[2,3] = "BC"  #// __Start__ 文字目から __Second__ 文字目まで
    echo ${variable: 2 : 2}   #// 空白は1つ目の : の右と、2つ目の : の左右に入れることができます
        #// CD
    echo ${variable: 2 : -2}  #// __Second__ がマイナスなら、右から指定した文字数だけ除く
        #// C                 #// mac では使えません  エラー substring expression < 0 になります
    echo ${variable: 2}       #// 2つ目の数字を指定しないなら、__Start__+1 文字目から最後まで。
        #// CDE
    echo ${variable: $((${#variable}-2))}  #// 右から 2文字
        #// DE
    echo "abcdefghijk" | rev | cut -c 2-3 | rev   #// 右から 2文字目から 3 文字目まで。 ただし rev は Git bash にありません
        #// ij
}
IndexSubString

echo  "### 区切り文字指定 ----------------------------"
function  SeparatorSubString() {
    local  variable="A.B.C"

    echo ${variable%%.*}  #// left of "."   #// ${__VAR__%%__keyword__*} は、最初（左）にマッチした位置より左
        #// A
    echo ${variable#*.*}  #// right of "."  #// ${__VAR__#*__keyword__*} は、最初（左）にマッチした位置より右
        #// B.C
    echo ${variable%.*}  #// left of last "."    #// ${__VAR__%__keyword__*} は、最後（右）にマッチした位置より左
        #// A.B
    echo ${variable##*.}  #// right of last "."  #// ${__VAR__##*__keyword__} は、最後（右）にマッチした位置より右
        #// C

    HasEqual  "A=2"
    HasEqual  "A"
}
function  HasEqual() {
    local  keyValue="$1"
    local  value="${keyValue#*=*}"  #// right of "="
    if [ "${#value}" != "${#keyValue}" ]; then  #// if "${keyValue}" has "="
        echo  "found"
    else
        echo  "not found"
    fi
}
SeparatorSubString

echo  "## 両端の空白文字やタブ文字を取り除く ----------------------------"
function  TrimExample() {
    local  tab=$'\t'
    local  before=" ${tab} a  b ${tab} "
    echo "(${before})"
        #// (    a  b    )

    local  after="$( echo "${before}"  |  sed -E "s/^( |${tab})*|( |${tab})*$//g" )"
    # local  after=$( echo "${before}"  |  sed -E 's/^\s*|\s*$//g' )  #// mac では使えません
    echo "(${after})"
        #// (a  b)

    local  after=${before}  #// "" で ${before} を囲まない場合
    echo "(${after})"
        #// (    a  b    )
}
function  Trim() {
    local  before="$1"
    echo  "${before}"  |  sed -E "s/^( |${tab})*|( |${tab})*$//g"
}
TrimExample
tab=$'\t'
after="$( Trim  " ${tab} a  b ${tab} " )"
echo  "(${after})"

echo  "## 文字数 ----------------------------"
__Variable__="ABC"

length=${#__Variable__}
echo  "${length}"

echo  "## 検索、含み判定、フィルター ----------------------------"
function  Includes() {
    local  __Variable__="$1"
    echo  "${__Variable__}"

    #// 含む
    if echo "${__Variable__}"  |  grep -E '^[0-9]+$' > /dev/null; then
        echo  "1. true"
    else
        echo  "1. false"
    fi

    #// マッチしない行がある
    if echo "${__Variable__}"  |  grep -E -v '^[0-9]+$' > /dev/null; then
        echo  "2. true"
    else
        echo  "2. false"
    fi

    #// 含まない。すべての行でマッチしない
    if !( echo "${__Variable__}"  |  grep -E '^[0-9]+$' > /dev/null ); then
        echo  "3. true"
    else
        echo  "3. false"
    fi

    if [ "$( echo "${__Variable__}"  |  grep -E '^[0-9]+$' )" == "" ]; then
        echo  "4. true"
    else
        echo  "4. false"
    fi

    if echo "${__Variable__}"  |  grep -qE '^[0-9]+$'; then
        echo  "5. true"
    else
        echo  "5. false"
    fi
}
local  LF=$'\n'
Includes  "abc"
Includes  "123"
Includes  "abc${LF}123"
