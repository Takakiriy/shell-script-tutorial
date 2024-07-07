#!/bin/bash

Host=$( jq -r '.database | .host'  "data.json" )
echo  "${Host}"

Port=$( jq -r '.database | .port'  "data.json" )
echo  "${Port}"

WithoutToString=$( jq -r '.database | .host + ":" + .port'  "data.json" )
echo  "${WithoutToString}"

HostAndPort=$( jq -r '.database | .host + ":" + (.port | tostring)'  "data.json" )
echo  "${HostAndPort}"
