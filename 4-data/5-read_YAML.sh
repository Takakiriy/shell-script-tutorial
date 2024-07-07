#!/bin/bash

Host=$( yq e '.database | .host'  "data.yaml" )
echo  "${Host}"

Port=$( yq e '.database | .port'  "data.yaml" )
echo  "${Port}"

HostAndPort=$( yq e '.database | .host + ":" + .port'  "data.yaml" )
echo  "${HostAndPort}"

ToString=$( yq e '.database | .host + ":" + (.port | tostring)'  "data.yaml" )
echo  "${ToString}"
