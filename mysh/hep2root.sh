#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: hep2root.sh [file]"
    echo ""
    echo " [file] file name"
    echo ""
    exit
fi

file=$1
name=${file%%.hep}
$ERADIR/ExRootSTDHEPConverter ${name}.hep ${name}.root