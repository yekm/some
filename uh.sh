#!/bin/bash

cat ~/.bash_history | grep "$1" | perl -pe 's/  / /g; s/^ //g;' | cut -f 1- -d' ' | sort -u | grep "$2"

