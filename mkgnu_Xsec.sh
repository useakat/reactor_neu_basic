#!/bin/bash

run_dir=$1

data_dir=${run_dir}/data

output=Xsec
#output=Xsec2
sed -e "s*DATADIR*${data_dir}*" ${output}_temp.gnu > temp.gnu
mv temp.gnu ${output}.gnu

gnuplot ${output}.gnu