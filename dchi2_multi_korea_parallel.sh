#!/bin/bash
    mode=0
# prepare output files    
    touch dchi2_multi_korea_nh_${Eres}_${Eres_nl}.dat
    touch dchi2_multi_korea_ih_${Eres}_${Eres_nl}.dat

# calculate the interval for each scan
    dxx=`echo "scale=5; $xxmax - $xxmin" | bc`
    dyy=`echo "scale=5; $yymax - $yymin" | bc`
    if [ $idivx -ne 0 ];then
	ddxx=`divide.sh $dxx $idivx 5` 
	ddyy=`divide.sh $dyy $idivy 5`
    fi

# submit jobs for the sensitivity scan
    if [ $idivx -eq 0 ];then # 1 point servey
	xx=$xxmin
	yy=$yymin
	jobname="job"$RANDOM
	./submit_job.sh $job_system $que 0 $jobname "../dchi2_multi_korea.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $binsize $theta ${nreactor} $xx $yy ${reactor_mode} ${reactor_type} ${ixsec} ${iPee}"
	count=1
    elif [ $idivx -ne 0 ];then # 2D scan
	i=0
	count=0
	while [ $i -le $idivx ];do
	    xx=`echo "scale=5; $xxmin + $ddxx * $i" | bc`
	    j=0
	    while [ $j -le $idivy ]; do
		yy=`echo "scale=5; $yymin + $ddyy * $j" | bc`
		jobname="job"$RANDOM
		./submit_job.sh $job_system $que $count $jobname "../dchi2_multi_korea.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $binsize $theta ${nreactor} $xx $yy ${reactor_mode} ${reactor_type}"
		j=`expr $j + 1`
		count=`expr $count + 1`
	    done
	    i=`expr $i + 1`
	done
    fi
    n1=$count
    
    ./monitor
    
    j=0
    while [ $j -lt $n1 ]; do
	cat par_${j}/dchi2_multi_nh_${Eres}_${Eres_nl}.dat >> dchi2_multi_korea_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/dchi2_multi_ih_${Eres}_${Eres_nl}.dat >> dchi2_multi_korea_ih_${Eres}_${Eres_nl}.dat
	cp par_${j}/final_bining_dat.dat data/.
	cp par_${j}/final_bining_th.dat data/.
	cp par_${j}/final_bining_dchi2.dat data/.
	j=`expr $j + 1`
    done

    rm -rf par_*

if [ $mail -eq 1 ]; then
    if [ $cluster == "kekcc" ]; then
        bsub -q ${que} -J $run -u takaesu@post.kek.jp nulljob.sh >/dev/null 2>&1
    else
        echo "Notification mail cannot be send from this cluster system. Exting..."
        exit
    fi
fi
