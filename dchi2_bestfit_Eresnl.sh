#!/bin/bash
    mv dchi2min_bestfit2nh_${Eres}_${Eres_nl}.dat dchi2min_bestfit2nh.dat
    mv dchi2min_bestfit2ih_${Eres}_${Eres_nl}.dat dchi2min_bestfit2ih.dat
    i=${Lmin}
    while [ $i -lt ${Lmaxp10} ]; do
#	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 0
	Lmin=$i
	source run_dchi2.sh
	mv evdinh.dat events_nh_${i}_${Eres}_${Eres_nl}.dat
	mv evdiih.dat events_ih_${i}_${Eres}_${Eres_nl}.dat
	mv evdinhmin.dat events_nhmin_${i}_${Eres}_${Eres_nl}.dat
	mv evdiihmin.dat events_ihmin_${i}_${Eres}_${Eres_nl}.dat
	i=`expr $i + 10`
    done