#!/usr/bin/env bash

#File: tree2githubmd
#Description: Convert output of unix tree utility to Github flavoured Markdown

tree="$(tree -f --noreport --charset ascii "$1" | sed -e 's/| \+/  /g' -e 's/[|`]-\+/ */g' -e 's:\(* \)\(\(.*/\)\([^/]\+\)\):\1[\4](\2):g')"
printf "# Code/Directory Structure:\n%s\n" "${tree}"
