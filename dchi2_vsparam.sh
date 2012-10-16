#!/bin/bash
    nvalue=10
    nvaluep1=`echo "${nvalue} +1" | bc`
    valuemax=`echo "scale=10;0.00232*(1+0.002)" | bc`
    valuemin=`echo "scale=10;0.00232*(1-0.002)" | bc`
    touch dchi2_vsparam_nh_total.dat
    i=1
    while [ $i -lt ${nvaluep1} ];do
	value=`echo "scale=10;${valuemin} +(${valuemax} -${valuemin})/${nvalue}*$i" | bc`
	./dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} $Eres_nl} ${mode} ${value}
	mv dchi2min_nh.dat dchi2min_nh_${Eres}_${Eres_nl}.dat
	mv dchi2min_ih.dat dchi2min_ih_${Eres}_${Eres_nl}.dat
	mv dchi2min_bestfit2ih.dat dchi2min_bestfit2ih_${Eres}_${Eres_nl}.dat
	mv dchi2min_bestfit2nh.dat dchi2min_bestfit2nh_${Eres}_${Eres_nl}.dat
	cat dchi2_vsparam_nh.dat >> dchi2_vsparam_nh_total.dat
	i=`expr $i + 1`
    done