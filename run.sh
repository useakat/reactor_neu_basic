#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: run.sh [run_name] [Eres] [Eres_nl] [run mode] (plot_run_mode)"
    echo ""
    exit
fi

if [[ $1 = "" ]]; then
    echo "input run name"
    read run
    echo "input energy resolution [%]"
    read Eres
    echo "input non-linear energy resolution [%]"
    read Eres_nl
    echo "input run mode: 0:All 1:Flux*Xsec 2:dN/dE 3:del-chi2 4:Free Analysis"
    read run_mode  
else
    run=$1
    Eres=$2
    Eres_nl=$3
    run_mode=$4
    plot_run_mode=$5
fi    
P=16.52 # YongGwang
V=5
R=0.12
Y=5
Lmin=10
Lmax=100
ndiv=100
binsize=0.0025 #binsize = binsize*sqrt{E_vis} (MeV)
ifixL=0
ifluc=0
theta=0
nreactor=0
xx=130
yy=34
if [ ${run_mode} -eq 10 ]; then
    ./plots.sh ${run} ${Eres} ${Eres_nl} 10 100 ${plot_run_mode}
    exit
fi

make clean >/dev/null 2>&1
rm -rf plots/*
rm -rf data/*
start_time=`date '+%s'`
date=`date '+%Y/%m/%d'`
ttime=`date '+%T'`
echo ${date} ${ttime}

run_dir=rslt_${run}
defout=${run_dir}/summary.txt

if [ -e ${run_dir} ]; then
#    rm -rf ${run_dir}/*
    echo "run directory exists."
else
    mkdir ${run_dir}
fi

echo ${date} ${ttime} > ${defout}

### start program ###

echo "" >> ${defout}
echo "[Input Parameters]" >> ${defout}
echo "Reactor Power:" $P "GW_{th}" >> ${defout}
echo "Detector Volume:" $V "kton" >> ${defout}
echo "Free Proton Weight Fraction:" $R >> ${defout}
echo "Exposure time:" $Y "year" >> ${defout}

cd DeltaChi2
make >/dev/null 2>&1
cd ..
make dchi2 >/dev/null 2>&1
make get_cl >/dev/null 2>&1

if [ ${run_mode} -eq 1 ] || [ ${run_mode} -eq 0 ] ; then  # plotting Flux*Xsec
    norm=1

    mode=1
    Lmin=1
    ./dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 0

    mode=5
    i=10
    while [ $i -lt 110 ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 0
	mv PeeNH.dat PeeNH_${i}.dat
	mv PeeIH.dat PeeIH_${i}.dat
	mv N_nh.dat N_nh_${i}.dat
	mv N_ih.dat N_ih_${i}.dat
	i=`expr $i + 10`
    done

    mode=3
    i=10
    while [ $i -lt 110 ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 0
	mv FluxXsec_loe.dat FluxXsec_loe_${i}.dat
	mv FluxXsecPeeNH_loe.dat FluxXsecPeeNH_loe_${i}.dat
	mv FluxXsecPeeIH_loe.dat FluxXsecPeeIH_loe_${i}.dat
	mv PeeNH_loe.dat PeeNH_loe_${i}.dat
	mv PeeIH_loe.dat PeeIH_loe_${i}.dat
	i=`expr $i + 10`
    done

fi    
if [ ${run_mode} -eq 2 ] || [ ${run_mode} -eq 0 ]; then  #plotting dN/dE
    mode=2
###### Analysis in the draft ###############################################
# Energy distributions
    i=10
    while [ $i -lt 110 ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 0
	mv evdinh.dat events_nh_${i}_${Eres}_${Eres_nl}.dat
	mv evdiih.dat events_ih_${i}_${Eres}_${Eres_nl}.dat
	i=`expr $i + 10`
    done
#######################################################################

#	mv edh6nh.dat events_6_nh_${i}.dat
#	mv edh6ih.dat events_6_ih_${i}.dat

    if [ 1 -eq 0 ]; then	
	i=10
	while [ $i -lt 110 ]; do
	    Eres=3
	    ./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode} 0 0
	    mv edh6nh.dat events_3_nh_${i}.dat
	    mv edh6ih.dat events_3_ih_${i}.dat
	
	    Eres=1.5
	    ./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode} 0 0
	    mv edh6nh.dat events_1.5_nh_${i}.dat
	    mv edh6ih.dat events_1.5_ih_${i}.dat
	    i=`expr $i + 10`
	done
    fi

fi

if [ ${run_mode} -eq 3 ] || [ ${run_mode} -eq 0 ]; then  # Analysis for paper
    switch1=0  # Fig.4 & 5
    switch2=0  # Fig.6
    switch3=0  # Fig.7
    switch4=0  # Fig.2 & 3 
    switch5=1  # parameter error

# chi2 fitting
    mode=0
    ifluc=0
    ifixL=0
#    binsize=0.0

    if [ ${switch1} -eq 1 ]; then 
	Eres=0
	Eres_nl=0
#	binsize=0.06
	source dchi2_fitting_Eresnl.sh
	Eres=6
	Eres_nl=0
#	binsize=0.06
	source dchi2_fitting_Eresnl.sh
	Eres=5
	Eres_nl=0
#	binsize=0.05
	source dchi2_fitting_Eresnl.sh
	Eres=4
	Eres_nl=0
#	binsize=0.04
	source dchi2_fitting_Eresnl.sh
	Eres=3
	Eres_nl=0
#	binsize=0.03
	source dchi2_fitting_Eresnl.sh
	Eres=2
	Eres_nl=0
#	binsize=0.03
	source dchi2_fitting_Eresnl.sh
    fi

    if [ ${switch2} -eq 1 ]; then 
	Eres=2
#	binsize=0.03
	Eres_nl=0.5
	source dchi2_fitting_Eresnl.sh
	Eres_nl=0.75
	source dchi2_fitting_Eresnl.sh
	Eres_nl=1
	source dchi2_fitting_Eresnl.sh
    fi

    if [ ${switch3} -eq 1 ]; then 
	Eres=3
#	binsize=0.03
	Eres_nl=0.5
	source dchi2_fitting_Eresnl.sh
	Eres_nl=0.75
	source dchi2_fitting_Eresnl.sh
	Eres_nl=1
	source dchi2_fitting_Eresnl.sh
    fi

    if [ ${switch4} -eq 1 ]; then 
#  Best Fit distributions and Data
	mode=2
	Lmaxp10=`expr ${Lmax} + 10`
	Eres=0
	Eres_nl=0
	source dchi2_bestfit_Eresnl.sh
	Eres=6
	Eres_nl=0
	source dchi2_bestfit_Eresnl.sh
    fi

    if [ ${switch5} -eq 1 ]; then 
	mode=0
	Eres=3
	Eres_nl=0.5
	source dchi2_fitting_Eresnl.sh
	Eres=3
	Eres_nl=1
	source dchi2_fitting_Eresnl.sh
	Eres=6
	Eres_nl=1
	source dchi2_fitting_Eresnl.sh
    fi
###############################################
    echo "" >> ${defout}
    cat dchi2_result.txt >> ${defout}
fi    

if [ ${run_mode} -eq 4 ]; then  # Free analysis
    mode=0

if [ 1 -eq 1 ];then # dchi2 evaluation for a parameter set
    maxL_nh=50
    maxL_ih=${maxL_nh}
    Eres=2
    Eres_nl=0
    binsize=0.005
    output=dchi2_binsize_nh_${Eres}_${Eres_nl}.dat
    touch ${output}
    source dchi2_dist_onepoint.sh
fi

if [ 0 -eq 1 ];then    
#    touch dchi2_cl_nh_${Eres}_${Eres_nl}.dat
#    touch dchi2_cl_ih_${Eres}_${Eres_nl}.dat
    maxL_nh=50
    maxL_ih=50
    # Y=0.3125
    # source dchi2_dist_error_only.sh
    # Y=0.555
    # source dchi2_dist_error_only.sh
    # Y=1.25
    # source dchi2_dist_error_only.sh
    # Y=5
    # source dchi2_dist_error_only.sh
#    Y=5
#    source dchi2_dist_error_only.sh
    Eres=6
    Eres_nl=0
    output=dchi2_binsize_nh_${Eres}_${Eres_nl}.dat
    touch ${output}
    source binsize_points.sh

    Eres=2
    Eres_nl=0
    output=dchi2_binsize_nh_${Eres}_${Eres_nl}.dat
    touch ${output}
    source binsize_points.sh

    Eres=3
    Eres_nl=0
    output=dchi2_binsize_nh_${Eres}_${Eres_nl}.dat
    touch ${output}
    source binsize_points.sh

    Eres=4
    Eres_nl=0
    output=dchi2_binsize_nh_${Eres}_${Eres_nl}.dat
    touch ${output}
    source binsize_points.sh

    Eres=5
    Eres_nl=0
    output=dchi2_binsize_nh_${Eres}_${Eres_nl}.dat
    touch ${output}
    source binsize_points.sh

    # binsize=0.00125
    # source dchi2_dist_onepoint.sh
    # cat dchi2_dist_nh.dat >> ${output}
    # binsize=0.0006
    # source dchi2_dist_onepoint.sh
    # cat dchi2_dist_nh.dat >> ${output}
#    source dchi2_dist_error_nostat.sh
#    Y=45
#    source dchi2_dist_error_only.sh
#    Y=80
#    source dchi2_dist_error_only.sh
fi

if [ 0 -eq 1 ];then
   Eres=3
   Eres_nl=0.75
   touch dchi2_cl_nh_${Eres}_${Eres_nl}.dat
   touch dchi2_cl_ih_${Eres}_${Eres_nl}.dat
   maxL_nh=50
   maxL_ih=50
    Y=0.555
    source dchi2_dist_error_only.sh
    Y=1.25
    source dchi2_dist_error_only.sh
    Y=5
    source dchi2_dist_error_only.sh
    Y=20
    source dchi2_dist_error_only.sh
    Y=45
    source dchi2_dist_error_only.sh
    Y=80
    source dchi2_dist_error_only.sh
    Y=125
    source dchi2_dist_error_only.sh
fi

    # Eres=2
    # Eres_nl=0
    # source dchi2_dist_error.sh
    # Eres_nl=0.5
    # source dchi2_dist_error.sh
    # Eres_nl=0.75
    # source dchi2_dist_error.sh
    # Eres_nl=1
    # source dchi2_dist_error.sh
    # Eres=3
    # Eres_nl=0
    # source dchi2_dist_error.sh
    # Eres_nl=0.5
    # source dchi2_dist_error.sh
    # Eres_nl=0.75
    # source dchi2_dist_error.sh
    # Eres_nl=1
    # source dchi2_dist_error.sh
    # Eres=4
    # Eres_nl=0
    # source dchi2_dist_error.sh
    # Eres=5
    # Eres_nl=0
    # source dchi2_dist_error.sh
    # Eres=6
    # Eres_nl=0
    # source dchi2_dist_error.sh
fi

if [ ${run_mode} -eq 5 ]; then  # Free analysis (parallel)
    job_system=bsub
    que=l

    if [ 1 -eq 1 ];then
	source dchi2_error_parallel.sh
    fi
fi

if [ ${run_mode} -eq 6 ]; then  # multi-reactor analysis for YongGwang (parallel)
    job_system=bsub
    que=l

    mode=0
    maxL_nh=50
    maxL_ih=${maxL_nh}
    binsize=0.005
    Eres=2
    Eres_nl=0.5
    nreactor=6
    source dchi2_multi_parallel.sh
#    ./dchi2_multi.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $binsize $theta ${nreactor}
fi

if [ ${run_mode} -eq 7 ]; then  # multi-reactor analysis for Korean reactors (parallel)
    job_system=bsub
    que=l

    mode=0
    maxL_nh=50
    maxL_ih=${maxL_nh}
    binsize=0.005
    Eres=2
    Eres_nl=0.5
    nreactor=-4
    source dchi2_multi_korea_parallel.sh
#    ./dchi2_multi.sh $P $V $R $Y $Eres $Eres_nl $mode $maxL_nh $maxL_ih $binsize $theta ${nreactor}
fi

mv *.dat data/.
cp -rf data ${run_dir}/.

./plots.sh ${run} ${Eres} ${Eres_nl} 10 100 ${run_mode}


### end program ###
    
end_time=`date '+%s'`
SS=`expr ${end_time} - ${start_time}` 
HH=`expr ${SS} / 3600` 
SS=`expr ${SS} % 3600` 
MM=`expr ${SS} / 60` 
SS=`expr ${SS} % 60` 
elapsed_time="${HH}:${MM}:${SS}" 
echo "Elapsed time:" $elapsed_time
echo "" >> ${defout}
echo "total time = " $elapsed_time >> ${defout}

echo ""
echo `date '+%T'`