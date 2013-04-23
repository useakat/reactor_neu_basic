#!/bin/bash
    mode=0

    i=1
    touch dchi2_multi_nh_${Eres}_${Eres_nl}.dat
    touch dchi2_multi_ih_${Eres}_${Eres_nl}.dat
    command="../dchi2_multi.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $binsize $theta ${nreactor}"

    idiv=10
    d=`divide.sh 3.141 $idiv 3`
    while [ $i -le 10 ];do
	theta=`echo "scale=3; $d * $i" | bc`
	jobname="job"$RANDOM
	./submit_job.sh $job_system $que $i $jobname "../dchi2_multi.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $binsize $theta ${nreactor}"
	i=`expr $i + 1`
    done
    n1=$i

    ./monitor

    j=1
    while [ $j -lt $n1 ]; do
	cat par_${j}/dchi2_dist_nh_${Eres}_${Eres_nl}.dat >> dchi2_multi_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/dchi2_dist_ih_${Eres}_${Eres_nl}.dat >> dchi2_multi_ih_${Eres}_${Eres_nl}.dat
	j=`expr $j + 1`
    done

    rm -rf par_*