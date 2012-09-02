#!/bin/bash

L=$1
P=$2
norm=$3

output=FluxXsec.gnu

sed -e "s/PPP/${P}/" \
    -e "s/LLL/${L}/" FluxXsec_temp.gnu > temp.gnu

if [ ${norm} -eq 1 ];then
    sed -e "s#TWO#(\$2/(2*\$1))#" temp.gnu > temp2.gnu
elif [ ${norm} -eq 2 ];then
    sed -e "s/TWO/2/" temp.gnu > temp2.gnu
fi
mv temp2.gnu temp.gnu

mv temp.gnu ${output}