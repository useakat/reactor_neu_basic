#!/bin/bash

L=$1
P=$2
V=$3
R=$4
Y=$5

RR=`echo "scale=1; ${R}*100" | bc`

output=basic_plots.gnu

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/YYY/${Y}/" basic_plots_temp.gnu > temp.gnu
mv temp.gnu ${output}