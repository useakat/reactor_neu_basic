#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
L=$5
#Eres=$6
run_dir=$6

data_dir=${run_dir}/data

RR=`echo "scale=1; ${R}*100" | bc`

output=EventDistmin_fit2nh_combine2
sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/LLL/${L}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/YYY/${Y}/" ${output}_temp.gnu > temp.gnu

mv temp.gnu ${output}.gnu

gnuplot ${output}.gnu
