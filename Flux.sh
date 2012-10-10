#!/bin/bash

run_dir=$1

data_dir=${run_dir}/data

output=Flux
sed -e "s/PPP/${P}/" \
    -e "s*DATADIR*${data_dir}*" \
    -e "s/LLL/${L}/" ${output}_temp.gnu > temp.gnu
mv temp.gnu ${output}.gnu

gnuplot ${output}.gnu