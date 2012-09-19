#!/bin/bash

L=$1
P=$2
run_dir=$3

data_dir=${run_dir}/data

sed -e "s/PPP/${P}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/LLL/${L}/" FvsE_temp.gnu > temp.gnu

mv temp.gnu FvsE.gnu

gnuplot FvsE.gnu