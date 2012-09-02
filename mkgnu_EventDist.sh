#!/bin/bash

P=$1
V=$2
R=$3
Y=$4

RR=`echo "scale=1; ${R}*100" | bc`

output=EventDist.gnu

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/YYY/${Y}/" EventDist_temp.gnu > temp.gnu

mv temp.gnu ${output}