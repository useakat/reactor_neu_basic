#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
fit_mode=$5
run_dir=$6
Eres_nl=$7

data_dir=${run_dir}/data

RR=`echo "scale=1; ${R}*100" | bc`

#if [ ${fit_mode} -eq -1 ];then
#    temp_file=dchi2_combine_temp.gnu
#elif [ ${fit_mode} -eq 1 ];then
#    temp_file=dchi2_param_errors_temp.gnu
#fi

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/ERESNL/${Eres_nl}/" \
    -e "s/YYY/${Y}/" dchi2_combine_temp.gnu > temp.gnu

mv temp.gnu dchi2_combine.gnu

gnuplot dchi2_combine.gnu


sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/ERESNL/${Eres_nl}/" \
    -e "s/YYY/${Y}/" dchi2_param_errors_temp.gnu > temp.gnu

mv temp.gnu dchi2_param_errors.gnu

gnuplot dchi2_param_errors.gnu