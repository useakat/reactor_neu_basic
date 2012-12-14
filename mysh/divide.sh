#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: divide.sh [num] [den] [digit]"
    echo ""
    echo " [num] numerator"
    echo " [den] denominator"
    echo ""
    exit
fi

num=$1
den=$2
digit=$3
c=`echo "scale=${digit}; ${num} / ${den}" |bc`
printf "%.${digit}f\n" ${c}