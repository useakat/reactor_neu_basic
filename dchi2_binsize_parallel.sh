#!/bin/bash
    selfdir=$(cd $(dirname $0);pwd)
    mode=0
    maxL_nh=50
    maxL_ih=${maxL_nh}
    Eres=2
    Eres_nl=0.5

    output1=dchi2_binsize_nh_${Eres}_${Eres_nl}.dat
    output2=dchi2_binsize_ih_${Eres}_${Eres_nl}.dat
    touch ${output1}
    touch ${output2}

    i=0
    binsize=2
    jobname="job"$RANDOM
    ./submit_job.sh $job_system $que $i $jobname "source ${selfdir}/dchi2_dist_onepoint.sh" 
#    source ${selfdir}/dchi2_dist_onepoint.sh
    i=`expr $i + 1`
    n1=$i

    ./monitor

#    cat dchi2_dist_nh_${Eres}_${Eres_nl}.dat >> ${output1}
#    cat dchi2_dist_ih_${Eres}_${Eres_nl}.dat >> ${output2}
    j=0
    while [ $j -lt $n1 ]; do
    	cat par_${j}/dchi2_dist_nh_${Eres}_${Eres_nl}.dat >> ${output1}
    	cat par_${j}/dchi2_dist_ih_${Eres}_${Eres_nl}.dat >> ${output2}
    	j=`expr $j + 1`
    done

    rm -rf par_*