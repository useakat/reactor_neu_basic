#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
fit_mode=$5

RR=`echo "scale=1; ${R}*100" | bc`

if [ ${fit_mode} -eq -1 ];then
    temp_file=dchi2_combine_temp.gnu
elif [ ${fit_mode} -eq 1 ];then
    temp_file=dchi2_param_errors_temp.gnu
fi

output=plot.gnu

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/YYY/${Y}/" ${temp_file} > temp.gnu

mv temp.gnu ${output}

gnuplot plot.gnu