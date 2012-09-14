#!/bin/bash

L=$1
P=$2

sed -e "s/PPP/${P}/" \
    -e "s/LLL/${L}/" FvsE_temp.gnu > temp.gnu

mv temp.gnu FvsE.gnu

gnuplot FvsE.gnu