#!/bin/bash

read line < dchi2_error_nh_${Eres}_${Eres_nl}.dat
L=`echo $line | cut -d' ' -f 1`
dchi2=`echo $line | cut -d' ' -f 2`
error=`echo $line | cut -d' ' -f 3`
dchi2_real=`./mysh/e2f.sh ${dchi2} 3`
make get_cl >/dev/null 2>&1
./get_cl ${dchi2_real} ${error}
cat cl.dat >> dchi2_cl_nh_${Eres}_${Eres_nl}.dat

read line < dchi2_error_ih_${Eres}_${Eres_nl}.dat
L=`echo $line | cut -d' ' -f 1`
dchi2=`echo $line | cut -d' ' -f 2`
error=`echo $line | cut -d' ' -f 3`
dchi2_real=`./mysh/e2f.sh ${dchi2} 3`
make get_cl >/dev/null 2>&1
./get_cl ${dchi2_real} ${error}
cat cl.dat >> dchi2_cl_ih_${Eres}_${Eres_nl}.dat