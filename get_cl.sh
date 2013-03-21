#!/bin/bash

selfdir=$(cd $(dirname $0);pwd)

read line < dchi2_error_nh_${Eres}_${Eres_nl}.dat
L=`echo $line | cut -d' ' -f 1`
dchi2=`echo $line | cut -d' ' -f 2`
error2=`echo $line | cut -d' ' -f 3`
mean_error=`echo $line | cut -d' ' -f 4`
error2_error=`echo $line | cut -d' ' -f 5`
${selfdir}/get_cl ${dchi2} ${error2} ${mean_error} ${error2_error}
cat cl.dat >> dchi2_cl_nh_${Eres}_${Eres_nl}.dat

read line < dchi2_error_ih_${Eres}_${Eres_nl}.dat
L=`echo $line | cut -d' ' -f 1`
dchi2=`echo $line | cut -d' ' -f 2`
error2=`echo $line | cut -d' ' -f 3`
mean_error=`echo $line | cut -d' ' -f 4`
error2_error=`echo $line | cut -d' ' -f 5`
${selfdir}/get_cl ${dchi2} ${error2} ${mean_error} ${error2_error}
cat cl.dat >> dchi2_cl_ih_${Eres}_${Eres_nl}.dat