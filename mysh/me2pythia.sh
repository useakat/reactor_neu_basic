#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: me2pythia.sh [run] (mode)"
    echo ""
    echo " [run] run name"
    echo " (mode) 0:serial, 1:pararell 2:multicore | 0"
    echo ""
    exit
fi

cd Events
../bin/run_pythia $PYDIR $2 $1 $ERADIR
ps2eps.sh $1_pythia