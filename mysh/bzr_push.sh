#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: bzr_push.sh [program]"
    echo ""
    exit
fi

program=$1

bzr push lp:~useakat/+junk/${program}
