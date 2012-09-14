#!/bin/bash

L=$1
P=$2
norm=$3

sed -e "s/PPP/${P}/" \
    -e "s/LLL/${L}/" FvsLoE_temp.gnu > temp.gnu

mv temp.gnu FvsLoE.gnu

gnuplot FvsLoE.gnu