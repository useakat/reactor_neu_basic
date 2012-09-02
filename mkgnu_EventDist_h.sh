#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
res=$5
norm=$6

RR=`echo "scale=1; ${R}*100" | bc`

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/YYY/${Y}/" \
    -e "s/ERES/${res}/" EventDist_h_temp.gnu > temp.gnu

if [ ${norm} -eq 1 ];then
    sed -e "s#TWO#(\$2/(2*\$1))#" temp.gnu > temp2.gnu
elif [ ${norm} -eq 2 ];then
    sed -e "s/TWO/3/" temp.gnu > temp2.gnu
fi
mv temp2.gnu plot.gnu

gnuplot plot.gnu