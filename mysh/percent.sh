#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: peercent.sh [num] [den]"
    echo ""
    echo " [num] numerator"
    echo " [den] denominator"
    echo ""
    exit
fi

p=1
a=`expr $1 \* 100`
b=$2
c=`echo "scale=${p}; ${a} / ${b}" |bc`
printf "%.${p}f\n" ${c}