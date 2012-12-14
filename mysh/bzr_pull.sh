#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: bzr_pull.sh [program]"
    echo ""
    exit
fi

program=$1
bzr pull lp:~useakat/+junk/${program}
