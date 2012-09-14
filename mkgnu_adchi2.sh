#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
L=$5

RR=`echo "scale=1; ${R}*100" | bc`

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/LLL/${L}/" \
    -e "s/YYY/${Y}/" adchi2_temp.gnu > temp.gnu

mv temp.gnu plot.gnu

gnuplot plot.gnu


sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/LLL/${L}/" \
    -e "s/YYY/${Y}/" int_adchi2_temp.gnu > temp.gnu

mv temp.gnu plot.gnu

gnuplot plot.gnu