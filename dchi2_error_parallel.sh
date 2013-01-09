#!/bin/bash

    mode=0
    maxL_nh=50
    maxL_ih=50

    i=1
    if [ 1 -eq 1 ]; then
    Eres=2
    Eres_nl=0.5
    touch dchi2_cl_nh_${Eres}_${Eres_nl}.dat
    touch dchi2_cl_ih_${Eres}_${Eres_nl}.dat
    touch sensitivity_nh_${Eres}_${Eres_nl}.dat
    touch sensitivity_ih_${Eres}_${Eres_nl}.dat

    Y=0.3125
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=1.25
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=2.5
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=3.75
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=5
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=8
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=10
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=15
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=20
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=28
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=36
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=45
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=60
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    fi
    n1=$i
    
    if [ 1 -eq 1 ];then
    Eres=3
    Eres_nl=0.75
    touch dchi2_cl_nh_${Eres}_${Eres_nl}.dat
    touch dchi2_cl_ih_${Eres}_${Eres_nl}.dat
    touch sensitivity_nh_${Eres}_${Eres_nl}.dat
    touch sensitivity_ih_${Eres}_${Eres_nl}.dat

#    Y=1.887 $3.4
#    Y=2.22 #4
    Y=0.3125
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=4.25 #3.4
#    Y=5 #4
    Y=1.25
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=8.5 #3.4
#    Y=10 #4
    Y=5
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    Y=10
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=13.6 #3.4
#    Y=16 #4
    Y=20
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=17 #3.4
#    Y=20 #4
    Y=35
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=34 #3.4
#    Y=40 #4
    Y=45
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=45
#    Y=51 #3.4
    Y=60 #4
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=60
#    Y=68 #3.4
    Y=80 #4
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=80
#    Y=95.2 #3.4
    Y=100
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=100
#    Y=122.4 #3.4
    Y=125 #4
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
#    Y=125
#    Y=153 #3.4
    Y=180 #3.4
    jobname="job"$RANDOM
    command="../dchi2_dist_error_only.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih"
    ./submit_job.sh $job_system $que $i $jobname "$command"
    i=`expr $i + 1`
    fi

    ./monitor

    Eres=2
    Eres_nl=0.5
    j=1
    while [ $j -lt $n1 ]; do
	cat par_${j}/dchi2_cl_nh_${Eres}_${Eres_nl}.dat >> dchi2_cl_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/dchi2_cl_ih_${Eres}_${Eres_nl}.dat >> dchi2_cl_ih_${Eres}_${Eres_nl}.dat
	cat par_${j}/sensitivity_error_nh_${Eres}_${Eres_nl}.dat >> sensitivity_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/sensitivity_error_ih_${Eres}_${Eres_nl}.dat >> sensitivity_ih_${Eres}_${Eres_nl}.dat
	j=`expr $j + 1`
    done
    Eres=3
    Eres_nl=0.75
    while [ $j -lt $i ]; do
	cat par_${j}/dchi2_cl_nh_${Eres}_${Eres_nl}.dat >> dchi2_cl_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/dchi2_cl_ih_${Eres}_${Eres_nl}.dat >> dchi2_cl_ih_${Eres}_${Eres_nl}.dat
	cat par_${j}/sensitivity_error_nh_${Eres}_${Eres_nl}.dat >> sensitivity_nh_${Eres}_${Eres_nl}.dat
	cat par_${j}/sensitivity_error_ih_${Eres}_${Eres_nl}.dat >> sensitivity_ih_${Eres}_${Eres_nl}.dat
	j=`expr $j + 1`
    done

    rm -rf par_*