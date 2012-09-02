#!/bin/bash

L=$1
P=$2
V=$3
R=$4
Y=$5

RR=`echo "scale=1; ${R}*100" | bc`

output=FluxXsec.gnu

sed -e "s/PPP/${P}/" \
    -e "s/LLL/${L}/" Flux_Xsec_temp.gnu > temp.gnu
mv temp.gnu ${output}