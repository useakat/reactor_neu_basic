#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: matching.sh [run] (mode) (it)"
    echo ""
    echo " [run] run name"
    echo " (mode) 0:serial, 1:pararell 2:multicore | 0"
    echo " (it) the number of iterations | 1"
    echo ""
    exit
fi

#find Cards -name "pythia_card.dat" -exec sed -i 's/QCUT=$1/QCUT=$2/' {}
#while read line; do
#    ${line//QCUT=10/QCUT=20}
#done < Cards/pythia_card.dat
echo -e "%s/QCUT=10/QCUT=20/g\\nw" | ed - Cards/pythia_card.dat