#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
Eres=$5

RR=`echo "scale=1; ${R}*100" | bc`

output=plot.gnu

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/ERES/${Eres}/" \
    -e "s/YYY/${Y}/" dchi2_temp.gnu > temp.gnu

mv temp.gnu ${output}

gnuplot plot.gnu