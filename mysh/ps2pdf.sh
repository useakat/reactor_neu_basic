#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: ps2pdf.sh [file]"
    echo ""
    echo " [file] ps file"
    echo ""
    exit
fi

file=$1
ps2pdf $file
rm $file