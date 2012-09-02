#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
res=$5
hmode=$6

RR=`echo "scale=1; ${R}*100" | bc`

output=EventDist_h.gnu

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/YYY/${Y}/" \
    -e "s/ERES/${res}/" EventDist_h_temp.gnu > temp.gnu

if [ ${hmode} -eq 1 ];then
    sed -e "s#TWO#(\$2/(2*\$1))#" temp.gnu > temp2.gnu
elif [ ${hmode} -eq 2 ];then
    sed -e "s/TWO/2/" temp.gnu > temp2.gnu
fi
mv temp2.gnu temp.gnu

mv temp.gnu ${output}