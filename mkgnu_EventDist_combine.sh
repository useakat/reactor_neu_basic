#!/bin/bash

P=$1
V=$2
R=$3
Y=$4

RR=`echo "scale=1; ${R}*100" | bc`

# output=EventDist_combine_0
# sed -e "s/PPP/${P}/" \
#     -e "s/VVV/${V}/" \
#     -e "s/RRR/${RR}/" \
#     -e "s/YYY/${Y}/" ${output}_temp.gnu > temp.gnu

# mv temp.gnu ${output}.gnu

# gnuplot ${output}.gnu

Eres=6
output=EventDist_combine
sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/ERES/${Eres}/" \
    -e "s/YYY/${Y}/" ${output}_temp.gnu > temp.gnu

mv temp.gnu ${output}.gnu

gnuplot ${output}.gnu