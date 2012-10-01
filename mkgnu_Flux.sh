#!/bin/bash

run_dir=$1
P=$2

data_dir=${run_dir}/data

output=Flux
#output=Flux2
sed -e "s/PPP/${P}/" \
    -e "s*DATADIR*${data_dir}*" ${output}_temp.gnu > temp.gnu
mv temp.gnu ${output}.gnu

gnuplot ${output}.gnu