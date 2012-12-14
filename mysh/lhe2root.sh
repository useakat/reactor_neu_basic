#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: lhe2root.sh [lhe]"
    echo ""
    echo " [lhe] lhe file name"
    echo ""
    exit
fi

path=$1
file=${path%.lhe}
$ERADIR/ExRootLHEFConverter ${file}.lhe ${file}.root  