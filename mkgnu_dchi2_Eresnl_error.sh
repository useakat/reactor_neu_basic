#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
Eres=$5
run_dir=$6

data_dir=${run_dir}/data
RR=`echo "scale=1; ${R}*100" | bc`

if [ ${Eres} -eq 3 ]; then
    output=dchi2_combine_Eresnl0to1_error_3
else
    output=dchi2_combine_Eresnl0to1_error
fi
sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/ERES/${Eres}/g" \
    -e "s/YYY/${Y}/" ${output}_temp.gnu > tmp.gnu
if [ ${Eres} -eq 2 ]; then
    sed -e "s/YMAX/22/" tmp.gnu > tmp2.gnu
    mv tmp2.gnu tmp.gnu
elif [ ${Eres} -eq 3 ];then
    sed -e "s/YMAX/10/" tmp.gnu > tmp2.gnu
    mv tmp2.gnu tmp.gnu
fi

mv tmp.gnu ${output}.gnu
gnuplot ${output}.gnu