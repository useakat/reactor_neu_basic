#!/bin/bash
    mode=0

    touch dchi2_multi_nh_${Eres}_${Eres_nl}.dat
    touch dchi2_multi_ih_${Eres}_${Eres_nl}.dat

    idiv=30
    d=`divide.sh 3.141 $idiv 5`
    i=0
    while [ $i -le $idiv ];do
	theta=`echo "scale=5; $d * $i" | bc`
	jobname="job"$RANDOM
	./submit_job.sh $job_system $que $i $jobname "../dchi2_multi.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $binsize $theta ${nreactor}"
	i=`expr $i + 1`
    done
    n1=$i

    ./monitor

    j=0
    while [ $j -lt $n1 ]; do
	cat par_${j}/dchi2_multi_nh_${Eres}_${Eres_nl}.dat >> dchi2_multi_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/dchi2_multi_ih_${Eres}_${Eres_nl}.dat >> dchi2_multi_ih_${Eres}_${Eres_nl}.dat
	j=`expr $j + 1`
    done

    rm -rf par_*