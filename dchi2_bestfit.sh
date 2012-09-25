#!/bin/bash
    mv dchi2min_bestfit2nh_${Eres}.dat dchi2min_bestfit2nh.dat
    mv dchi2min_bestfit2ih_${Eres}.dat dchi2min_bestfit2ih.dat
    touch int_adchi2_fit2nh_${Eres}.dat
    touch int_adchi2_fit2ih_${Eres}.dat
    i=${Lmin}
    while [ $i -lt ${Lmaxp10} ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode}
	mv evdinh.dat events_nh_${i}_${Eres}.dat
	mv evdiih.dat events_ih_${i}_${Eres}.dat
	mv evdiihmin.dat events_ihmin_${i}_${Eres}.dat
	mv evdinhmin.dat events_nhmin_${i}_${Eres}.dat
#       	mv event_min2nh.dat ${run_dir}/events_fit2nh_${i}_${Eres}.txt
#       	mv event_min2ih.dat ${run_dir}/events_fit2ih_${i}_${Eres}.txt
	mv adchi2_fit2nh.dat adchi2_fit2nh_${i}_${Eres}.dat
	mv adchi2_fit2ih.dat adchi2_fit2ih_${i}_${Eres}.dat
	read int_adchi2 < int_adchi2_fit2nh.dat 
	echo $i ${int_adchi2} >> int_adchi2_fit2nh_${Eres}.dat
	read int_adchi2 < int_adchi2_fit2ih.dat 
	echo $i ${int_adchi2} >> int_adchi2_fit2ih_${Eres}.dat
	i=`expr $i + 10`
    done