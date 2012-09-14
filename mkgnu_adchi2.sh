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

mv temp.gnu adchi2.gnu

gnuplot adchi2.gnu


sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/LLL/${L}/" \
    -e "s/YYY/${Y}/" int_adchi2_temp.gnu > temp.gnu

mv temp.gnu int_adchi2.gnu

gnuplot int_adchi2.gnu