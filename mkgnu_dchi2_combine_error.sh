#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
Eres_nl=$5
run_dir=$6

data_dir=${run_dir}/data
RR=`echo "scale=1; ${R}*100" | bc`

output=dchi2_combine_65432_error
sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/ERESNL/${Eres_nl}/" \
    -e "s/YYY/${Y}/" ${output}_temp.gnu > temp.gnu
mv temp.gnu ${output}.gnu
gnuplot ${output}.gnu
