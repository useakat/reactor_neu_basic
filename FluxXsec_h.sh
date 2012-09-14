#!/bin/bash

L=$1
P=$2

output=FluxXsec_h.gnu

sed -e "s/PPP/${P}/" \
    -e "s/LLL/${L}/" FluxXsec_h_temp.gnu > temp.gnu
mv temp.gnu ${output}

gnuplot ${output}