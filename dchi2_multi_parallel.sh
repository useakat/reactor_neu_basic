#!/bin/bash
    mode=6

    i=1
    Eres=2
    Eres_nl=0.5
    touch dchi2_multi_nh_${Eres}_${Eres_nl}.dat
    touch dchi2_multi_ih_${Eres}_${Eres_nl}.dat
    command="../dchi2_multi.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $theta ${nreactor}"
    
    theta=0
    jobname="job"$RANDOM
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    theta=0.85
    jobname="job"$RANDOM
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    theta=1.75
    jobname="job"$RANDOM
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`

    n1=$i

    ./monitor

    j=1
    while [ $j -lt $n1 ]; do
	cat par_${j}/dchi2_multi_nh_${Eres}_${Eres_nl}.dat >> dchi2_multi_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/dchi2_multi_ih_${Eres}_${Eres_nl}.dat >> dchi2_multi_ih_${Eres}_${Eres_nl}.dat
	j=`expr $j + 1`
    done

    rm -rf par_*