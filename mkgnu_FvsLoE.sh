#!/bin/bash

L=$1
P=$2
norm=$3
run_dir=$4

data_dir=${run_dir}/data

sed -e "s/PPP/${P}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/LLL/${L}/" FvsLoE_temp.gnu > temp.gnu

mv temp.gnu FvsLoE.gnu

gnuplot FvsLoE.gnu