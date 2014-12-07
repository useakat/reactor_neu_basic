#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
#    echo "Usage: run.sh [run_name] [run_mode] [Eres_a] [Eres_b] [reactor mode] [reactor type] (plot_run_mode)"
    echo "Usage: run.sh [run_name] [Eres_a] [Eres_b]"
    echo ""
    echo "run_name: name of a program run" 
#    echo "run_mode: 0:All 1:Flux*Xsec 2:dN/dE 3:dchi2 4:Free Analysis 10:plot-only mode"
    echo "Eres: Energy resolution [%]"
    echo "Eres_b: Non-linear energy resolution [%]"
#    echo "reactor mode: 0:use the averaged position of reactor cores 1:use each position of reactor cores"
#    echo "reactor type: 0:only operating reactors 1:add planned reactors "
#    echo "plot_run_mode (only valid for run_mode=10): select run mode for plotting"
    echo ""
    exit
fi
selfdir=$(cd $(dirname $0);pwd)

###
### Default argument values
###
run=test # Name of this program runing (It will be used as the name of a directory (e.g. rslt_test), where running results are output)
#run_mode=4 # 0:dchi^2 analysis 1:For dsqrt(E_nu) distributions 2:For dN/dE plots 3:For L/E distributions 4:For E_nu distributions 5:dN/dE distributions
Eres_a=3 # [%] Energy resolution of a detector (statisticl "a" parameter (cf. 1210.8141)) 
Eres_b=1 # [%] Energy resolution of a detector (non-statisticl "b" parameter (cf. 1210.8141)) 
reactor_mode=0 # 0:use the averaged position of reactor cores 1:use each position of reactor cores
reactor_type=0 # 0:only operating reactors 1:add planned reactors

# ###
# ### Argument input routine
# ###
# if [ $# -eq 0 ]; then  
#     echo "input run name"
#     read run
#     echo "input run mode: 0:All 1:Flux*Xsec 2:dN/dE 3:dchi2 4:Free Analysis"
#     read run_mode  
#     echo "input energy resolution [%]"
#     read Eres
#     echo "input non-linear energy resolution [%]"
#     read Eres_b
#     echo "reactor_mode: 0:use the averaged position of reactor cores 1:use each position of reactor cores"
#     read reactor_mode
#     echo "reactor_type: 0:only operating reactors 1:add planned reactors "
#     read reactor_type
# else
#     if [ $# -ge 1 ];then
# 	run=$1
#     fi
#     if [ $# -ge 2 ];then
# 	run_mode=$2
#     fi
#     if [ $# -ge 3 ];then
# 	Eres_a=$3 
#     fi
#     if [ $# -ge 4 ];then
# 	Eres_b=$4
#     fi
#     if [ $# -ge 5 ];then
# 	reactor_mode=$5
#     fi
#     if [ $# -ge 6 ];then
# 	reactor_type=$6
#     fi
#     if [ $# -ge 7 ];then
# 	plot_run_mode=$7
#     fi
# fi

############### internal parameters ######################
P=16.4 # [GW] Total thermal power of a nuclear plant
# P=16.4 for YongGwang http://dx.doi.org/10.1155/2014/320287
# P=35.8 for JUNO

V=18 # [kton] Size of a detector
# V=18 for RENO-50 http://dx.doi.org/10.1155/2014/320287
# V=20 for JUNO
# V=0.16 for DayaBay Total
# V=0.0165 for RENO

R=0.12 # Proton weight-ratio in a detector scintillator
Y=5 # [years] running time of an experiment

Lmin=10 # [km] minimum baseline length (L) for the baseline length scan
Lmax=100 # [km] maximum baseline length (L) for the baseline length scan
ndiv=20 # The number of division for the baseline length scan
# Note: Lmin, Lmax, ndiv are used for preparing Delta_chi^2 vs baseline length table

binsize_factor=0.0025 # Bin size for chi^2 minimization. Bin size =  binsize_factor * sqrt{E_vis} (E_vis in [MeV]). binsize_factor = 0.0025 is used in 1210.8141.

######## Switches #############
mode=0 
# 0:Perform dchi^2 minimization 

ifixL=0 # Switch for baseline-length scan
        #   0: Evaluate dchi^2_min for a baseline length set by Lmin 
        #   1: Perform baseline-length scan for dchi^2_min from Lmin to Lmax with (ndiv +1) scanning points. 
        # Note: ifixL is only valid for mode=0.

ifluc=0 # Switch for data fluctuation
        #   0: Data fluctuation is not included. ( [Observed event number] = [Theoretically predicted event number] for each bin ) 
        #   1: Data fluctuation is included. (Observed event number in each bin is fluctuated by a Gaussian distribution around a theoretical Prediction.
        #      The variance of the Gaussian is the observed event number.)
        # In this program, we first calculate "Observed" event numbers for bins in reconstruted neutrino energy (Erec). 
        # Next we calculate "Predicted" event numbers and perform chi^2 minimization for a parameter fitting. 

ixsec=1 # Switch for Inverse beta decay (IBD) cross section treatment
        #   0: Include Nulear recoil effect (approx) 
        #   1: Neglect the recoil effect 

iPee=0 # Switch for different mass difference squared parameterizations 
       #   0: dm31_2-dm32_2 parametreization
       #   1: dmee_2 parameterization

theta=0
nreactor=0 # The number of reactor cores at Yongwang or The number of reactor sites for negative value 
xx=130 # default tokei for 1 point servey
yy=34  # default hokui for 1 point servey

### plot only option
#if [ ${run_mode} -eq 10 ]; then
#    ./plots.sh ${run} ${Eres_a} ${Eres_b} 10 100 ${plot_run_mode}
#    exit
#fi

########## main program #############################
#-----Initialization 
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
    echo "run directory exists. The files will be overwritten."
else
    mkdir ${run_dir}
fi

echo ${date} ${ttime} > ${defout}

echo "" >> ${defout}
echo "[Input Parameters]" >> ${defout}
echo "Reactor Power:" $P "GW_{th}" >> ${defout}
echo "Detector Volume:" $V "kton" >> ${defout}
echo "Free Proton Weight Fraction:" $R >> ${defout}
echo "Exposure time:" $Y "year" >> ${defout}

cd DeltaChi2
make
cd ..
make dchi2
make get_cl

##-------- plotting Flux*Xsec
#if [ ${run_mode} -eq 1 ] || [ ${run_mode} -eq 0 ] ; then  
#    norm=1

##-------- dsqrt(E) distribution
#    mode=1
#    Lmin=10
#    source ./run_dchi2.sh

##-------- dN/dE distribution
#    mode=5
#    i=10
#    while [ $i -lt 110 ]; do
#	Lmin=$i
#	source ./run_dchi2.sh
#	mv PeeNH.dat PeeNH_${i}.dat
#	mv PeeIH.dat PeeIH_${i}.dat
#	mv N_nh.dat N_nh_${i}.dat
#	mv N_ih.dat N_ih_${i}.dat
#	i=`expr $i + 10`
#    done

##-------- L/E distribution 
#    mode=3
#    i=10
#    while [ $i -lt 110 ]; do
#	Lmin=$i
#	source ./run_dchi2.sh
#	mv FluxXsec_loe.dat FluxXsec_loe_${i}.dat
#	mv FluxXsecPeeNH_loe.dat FluxXsecPeeNH_loe_${i}.dat
#	mv FluxXsecPeeIH_loe.dat FluxXsecPeeIH_loe_${i}.dat
#	mv PeeNH_loe.dat PeeNH_loe_${i}.dat
#	mv PeeIH_loe.dat PeeIH_loe_${i}.dat
#	i=`expr $i + 10`
#    done

#fi    
#if [ ${run_mode} -eq 2 ] || [ ${run_mode} -eq 0 ]; then  #plotting dN/dE
#    mode=2
##--------- Analysis in the draft
## Energy distributions
##    binsize_factor = 0.05
#    i=10
#    while [ $i -lt 110 ]; do
#	Lmin=$i
#	source ./run_dchi2.sh
##	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres_a} ${Eres_b} ${mode} 0 0
#	mv evdinh.dat events_nh_${i}_${Eres_a}_${Eres_b}.dat
#	mv evdiih.dat events_ih_${i}_${Eres_a}_${Eres_b}.dat
#	i=`expr $i + 10`
#    done

#	mv edh6nh.dat events_6_nh_${i}.dat
#	mv edh6ih.dat events_6_ih_${i}.dat

#    if [ 1 -eq 0 ]; then	
#	i=10
#	while [ $i -lt 110 ]; do
#	    Lmin=$i
#	    Eres_a=3
#	    source ./run_dchi2.sh
##	    ./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres_a} ${mode} 0 0
#	    mv edh6nh.dat events_3_nh_${i}.dat
#	    mv edh6ih.dat events_3_ih_${i}.dat
#	
#	    Eres_a=1.5
#	    source ./run_dchi2.sh
##	    ./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres_a} ${mode} 0 0
#	    mv edh6nh.dat events_1.5_nh_${i}.dat
#	    mv edh6ih.dat events_1.5_ih_${i}.dat
#	    i=`expr $i + 10`
#	done
#    fi
#
#fi

#----------- Sample analyses
#if [ ${run_mode} -eq 4 ]; then  
mode=0
## dchi2 analysis
    if [ 1 -eq 1 ]; then 
	ifixL=0
	ifluc=0
	binsize=0.025d0
	source dchi2_fitting.sh
    fi

    if [ 0 -eq 1 ];then # updated parameter study
	ifixL=1
	ifluc=0
	ndiv=10
	Lmin=50
	Lmax=${Lmin}
	Eres_a=2
	Eres_b=1
	binsize_factor=0.0025
	source dchi2_fitting_Eresnl.sh
    fi

    if [ 0 -eq 1 ];then fluctuation study 
	ifixL=1
	ifluc=1
	ndiv=1
	maxL_nh=50
	maxL_ih=${maxL_nh}
	Eres_a=3
	Eres_b=0.75
	binsize_factor=0.005
	output=dchi2_fluc_nh_${Eres_a}_${Eres_b}.dat
	touch ${output}
	source ${selfdir}/dchi2_fitting_Eresnl.sh
	cat dchi2_dist_nh_${Eres_a}_${Eres_b}.dat >> ${output}
    fi
    
    if [ 0 -eq 1 ];then # binsize study
	maxL_nh=50
	maxL_ih=${maxL_nh}
	Eres_a=3
	Eres_b=0.75
	binsize_factor=2
	output=dchi2_binsize_nh_${Eres_a}_${Eres_b}.dat
	touch ${output}
	source dchi2_dist_onepoint.sh
	cat dchi2_dist_nh_${Eres_a}_${Eres_b}.dat >> ${output}
    fi
    
    if [ 0 -eq 1 ];then # binsize study
#    touch dchi2_cl_nh_${Eres_a}_${Eres_b}.dat
#    touch dchi2_cl_ih_${Eres_a}_${Eres_b}.dat
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
	Eres_a=6
	Eres_b=0
	output=dchi2_binsize_nh_${Eres_a}_${Eres_b}.dat
	touch ${output}
	source binsize_points.sh
	
	Eres_a=2
	Eres_b=0
	output=dchi2_binsize_nh_${Eres_a}_${Eres_b}.dat
	touch ${output}
	source binsize_points.sh
	
	Eres_a=3
	Eres_b=0
	output=dchi2_binsize_nh_${Eres_a}_${Eres_b}.dat
	touch ${output}
	source binsize_points.sh
	
	Eres_a=4
	Eres_b=0
	output=dchi2_binsize_nh_${Eres_a}_${Eres_b}.dat
	touch ${output}
	source binsize_points.sh
	
	Eres_a=5
	Eres_b=0
	output=dchi2_binsize_nh_${Eres_a}_${Eres_b}.dat
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
#fi

#if [ ${run_mode} -eq 5 ]; then  # Free analysis (parallel)
#    job_system=bsub
##    que=l
#    que=e
#
#    if [ 1 -eq 1 ];then
##	source dchi2_error_parallel.sh
#	source dchi2_binsize_parallel.sh
#    fi
#fi

#if [ ${run_mode} -eq 6 ]; then  # multi-reactor analysis in the polar cordinate (parallel)
#    job_system=bsub
#    que=l
#
#    mode=0
#    maxL_nh=50
#    maxL_ih=${maxL_nh}
#    binsize_factor=0.005
#    Eres_a=2
#    Eres_b=0.5
#    nreactor=6
#    source dchi2_multi_parallel.sh  # (under construction due to the new ixsec flag)
#fi

#if [ ${run_mode} -eq 7 ]; then  # multi-reactor analysis for Korean reactors (parallel)
#    cluster=kekcc
#    job_system=bsub
#    que=e
#    mail=1
##    mode=0
#    maxL_nh=50
#    maxL_ih=${maxL_nh}
#    binsize_factor=0.0025
##    binsize=0.01
#    Eres_a=3
#    Eres_b=0.5
#    nreactor=-4 # >0:The number of reactor cores -1:YongGwang -2:+Kori -3:+Wolsong -4:+Ulchin
#    reactor_mode=1 # 0:use the averaged position of reactor cores 1:use each position of reactor cores
#    reactor_type=0 # 0:only operating reactors 1:add planned reactors 
## The scan region
#    xxmin=125.8
#    xxmax=130
#    yymin=34
#    yymax=38
## The number of division for the sensitivity scan
#    idivx=40 
#    idivy=40 
#    source dchi2_multi_korea_parallel.sh
#fi

############### Finishing mainprogram ###################
mv *.dat data/.
cp -rf data ${run_dir}/.

#./plots.sh ${run} ${Eres_a} ${Eres_b} 10 100 ${run_mode}

################ Timing ##################################
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