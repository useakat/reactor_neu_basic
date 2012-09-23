#!/bin/bash

L=$1
P=$2
norm=$3
run_dir=$4

data_dir=${run_dir}/data

sed -e "s/PPP/${P}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/LLL/${L}/" FluxXsec_h_temp.gnu > temp.gnu

if [ ${norm} -eq 1 ];then
    sed -e "s#TWO#(\$2/(2*\$1))#" temp.gnu > temp2.gnu
elif [ ${norm} -eq 2 ];then
    sed -e "s/TWO/2/" temp.gnu > temp2.gnu
fi
mv temp2.gnu FluxXsec_h.gnu

gnuplot FluxXsec_h.gnu