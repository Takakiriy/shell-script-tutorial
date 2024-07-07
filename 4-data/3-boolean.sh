#!/bin/bash

condition="true"
    #// または
condition="false"

if [ "${condition}" == "true" ]; then
    echo  "OK"
else
    echo  "NG"
fi

true
echo $?   #// （終了コード）0

false
echo $?   #// （終了コード）1

if true; then
    echo  "OK"
fi

True=0
False=1
EnableAccess="${True}"
echo  "${EnableAccess}"

dollar="-x"
if [ "${dollar}" == "-x" ]; then
    OptionX="yes"
fi

if [ "${OptionX}" != "" ]; then
    echo  "enabled"
fi
