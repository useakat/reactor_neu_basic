#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: replace.sh [file] [pat] [char]"
    echo ""
    echo " [file] file name"
    echo " [pat] pattern to be replaced"
    echo " [char] character to be put"
    echo ""
    exit
fi

echo -e "%s/$2/$3/g\\nw" | ed - $1