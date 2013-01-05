#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)
    ${selfdir}/dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} $Eres_nl} ${mode} 0 ${ifixL} ${ifluc}
    if [ ${ifixL} -eq 0 ];then
	mv dchi2min_nh.dat dchi2min_nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_ih.dat dchi2min_ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_bestfit2ih.dat dchi2min_bestfit2ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_bestfit2nh.dat dchi2min_bestfit2nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
    else
#	read line < dchi2_error_nh.dat
#	L=`echo $line | cut -d' ' -f 1`
#	dchi2=`echo $line | cut -d' ' -f 2`
#	error=`echo $line | cut -d' ' -f 3`
#	echo ${L} ${dchi2} ${error} > dchi2_error_nh_${Eres}_${Eres_nl}.dat
	mv dchi2_error_nh.dat dchi2_error_nh_${Eres}_${Eres_nl}.dat

#	read line < dchi2_error_ih.dat
#	L=`echo $line | cut -d' ' -f 1`
#	dchi2=`echo $line | cut -d' ' -f 2`
#	error=`echo $line | cut -d' ' -f 3`
#	echo ${L} ${dchi2} ${error} > dchi2_error_ih_${Eres}_${Eres_nl}.dat
	mv dchi2_error_ih.dat dchi2_error_ih_${Eres}_${Eres_nl}.dat
    fi