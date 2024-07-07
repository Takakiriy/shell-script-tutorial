#!/bin/bash

function  Main() {
    Query  "111"
    Query  "123"
    Query  "999"
    Query  "222"  --escape
}

function  Query() {
    local  idKey="$1"
    local  option="$2"
    local  csvFilePath="data.csv"
    if [ "${option}" == "" ]; then

        local  value="$( awk -F ','  -v idKey="${idKey}" \
            '$1 == idKey {print $2}' \
            "${csvFilePath}" )"
    elif [ "${option}" == "--escape" ]; then
        echo  "escaped"
        local  value="$( awk -F ','  -v idKey="${idKey}" \
            '$1 == idKey {print $2}' \
            <( cat "${csvFilePath}"  |  sed -E 's/("[^"]*),([^"]*")/\1\\,\2/g' ) )"  #// 未対応
    fi

    if [ -n "${value}" ]; then
        echo  "ID ${idKey} の value: (${value})"
    else
        echo  "ID ${idKey} は見つかりませんでした。"
    fi
}
Main  "$@"
