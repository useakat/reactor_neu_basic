#!/bin/bash
    selfdir=$(cd $(dirname $0);pwd)
    ipara=1

    mode=0
    Lmin=50
    Lmax=${Lmin}
    Eres=6
    Eres_nl=0.5
    ifixL=1  
    ifluc=0
    ndiv=0

    output1=dchi2_binsize_nh_${Eres}_${Eres_nl}.dat
    output2=dchi2_binsize_ih_${Eres}_${Eres_nl}.dat
    touch ${output1}
    touch ${output2}

    if [ $ipara -eq 1 ]; then
	ddiv=100
	min=0.4
	max=4
	del=`echo "scale=5; ($max-$min)/$ddiv" | bc` 	
	i=0
	while [ $i -le $ddiv ];do
	    binsize[$i]=`echo "scale=5; $min +$del*$i" | bc`
	    jobname="job"$RANDOM
	    ./submit_job.sh $job_system $que $i $jobname "${selfdir}/dchi2_dist_onepoint_sa.sh $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 ${ifixL} ${ifluc} ${binsize[$i]} ${theta} ${nreactor} $xx $yy ${reactor_mode} ${reactor_type} ${ixsec} ${iPee}"  
	    i=`expr $i + 1`
	done
	n1=$i
    else
	binsize=1.5
	${selfdir}/dchi2_dist_onepoint_sa.sh $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 ${ifixL} ${ifluc} ${binsize} ${theta} ${nreactor} $xx $yy ${reactor_mode} ${reactor_type}
    fi

    if [ $ipara -eq 1 ]; then
	./monitor
    fi

    if [ $ipara -eq 1 ];then
	j=0
	while [ $j -lt $n1 ]; do
    	    echo ${binsize[$j]} `cat par_${j}/dchi2_dist_nh_${Eres}_${Eres_nl}.dat` >> ${output1}
    	    echo ${binsize[$j]} `cat par_${j}/dchi2_dist_ih_${Eres}_${Eres_nl}.dat` >> ${output2}
#	    cat par_${j}/final_bining_dat.dat > final_bining_dat_${binsize[$j]}.dat 
#	    cat par_${j}/final_bining_th.dat > final_bining_th_${binsize[$j]}.dat 
	    read aa nbins < par_${j}/dchi2_dist_nh_${Eres}_${Eres_nl}.dat
	    cat par_${j}/final_bining_dchi2.dat > final_bining_dchi2_${nbins}.dat 
	    cat par_${j}/final_bining_dat.dat > final_bining_dat_${nbins}.dat 
	    cat par_${j}/final_bining_th.dat > final_bining_th_${nbins}.dat 
    	    j=`expr $j + 1`
	done
	mv par_0/*.dat .
	rm -rf par_*
    else
	cat dchi2_dist_nh_${Eres}_${Eres_nl}.dat >> ${output1}
	cat dchi2_dist_ih_${Eres}_${Eres_nl}.dat >> ${output2}
    fi