#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
run_dir=$5

data_dir=${run_dir}/data

RR=`echo "scale=1; ${R}*100" | bc`

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/YYY/${Y}/" EventDist_temp.gnu > temp.gnu

mv temp.gnu EventDist.gnu

gnuplot EventDist.gnu


output=EventDist_combine_0
sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/YYY/${Y}/" ${output}_temp.gnu > temp.gnu

mv temp.gnu ${output}.gnu

gnuplot ${output}.gnu