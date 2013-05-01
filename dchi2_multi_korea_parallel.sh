#!/bin/bash
    mode=0

    touch dchi2_multi_korea_nh_${Eres}_${Eres_nl}.dat
    touch dchi2_multi_korea_ih_${Eres}_${Eres_nl}.dat

    xxmin=125.8
    xxmax=130
    yymin=34
    yymax=38

    dxx=`echo "scale=5; $xxmax - $xxmin" | bc`
    dyy=`echo "scale=5; $yymax - $yymin" | bc`

    idivx=40
    idivy=40
    ddxx=`divide.sh $dxx $idivx 5`
    ddyy=`divide.sh $dyy $idivy 5`

    i=0
    count=0
    while [ $i -le $idivx ];do
	xx=`echo "scale=5; $xxmin + $ddxx * $i" | bc`
	j=0
	while [ $j -le $idivy ]; do
	    yy=`echo "scale=5; $yymin + $ddyy * $j" | bc`
	    jobname="job"$RANDOM
	    ./submit_job.sh $job_system $que $count $jobname "../dchi2_multi_korea.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $binsize $theta ${nreactor} $xx $yy"
	    j=`expr $j + 1`
	    count=`expr $count + 1`
	done
	i=`expr $i + 1`
    done
    n1=$count

    ./monitor

    j=0
    while [ $j -lt $n1 ]; do
	cat par_${j}/dchi2_multi_nh_${Eres}_${Eres_nl}.dat >> dchi2_multi_korea_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/dchi2_multi_ih_${Eres}_${Eres_nl}.dat >> dchi2_multi_korea_ih_${Eres}_${Eres_nl}.dat
	j=`expr $j + 1`
    done

    rm -rf par_*