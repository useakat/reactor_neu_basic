#!/bin/bash
if [[ $1 = "" ]]; then
    echo "input run name"
    read run
    echo "input energy resolution [%]"
    read Eres
    echo "input non-linear energy resolution [%]"
    read Eres_nl
#    echo "input reactor Power [GW]"
#    read P
#    echo "input baseline length [km]"
#    read L
#    echo "input detector volume [kton]"
#    read V
#    echo "input free proton fraction in the detector"
#    read R 
#    echo "input exposure time [year]"
#    read Y 
#    echo "input Energy Resolution"
#    read Eres
    echo "input Lmin"
    read Lmin
    echo "input Lmax"
    read Lmax 
    echo "input mode"
    read mode  
else
    run=$1
#P=$2
#V=$3
#R=$4
#Y=$5
    Eres=$2
    Eres_nl=$3
    Lmin=$4
    Lmax=$5
    mode=$6
fi

P=20
V=5
R=0.12
Y=5

norm=1
Lmaxp10=`expr ${Lmax} + 10`
run_dir=rslt_${run}

if [ ${mode} -eq 1 ]; then
    ./mkgnu_Flux.sh ${run_dir} $P
    ./mkgnu_Xsec.sh ${run_dir}
    ./mkgnu_FluxXsec.sh ${Lmin} $P ${norm} ${run_dir}
    ./mkgnu_FluxXsec_h.sh ${Lmin} $P ${norm} ${run_dir}
    ./mkgnu_N.sh $P $V $R $Y ${Eres} ${Eres_nl} ${run_dir}

    i=${Lmin}
    while [ $i -lt ${Lmaxp10}  ]; do 
	./mkgnu_FvsLoE.sh $i $P ${norm} ${run_dir}
	./mkgnu_FvsE.sh $i $P ${run_dir}
	i=`expr $i + 10`
    done

elif [ ${mode} -eq 2 ]; then
##### Plots in the draft #############################################
# Energy distributions
    ./mkgnu_EventDist.sh $P $V $R $Y ${Eres} ${Eres_nl} ${run_dir}
#####################################################################

#     norm=2
#     Eres=6
#     ./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
#     Eres=3
#     ./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
#     Eres=1.5
#     ./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}

elif [ ${mode} -eq 3 ]; then
##### Plots in the draft #############################################
# Delta Chi^2 distributions
    ./mkgnu_dchi2_combine.sh $P $V $R $Y ${Eres_nl} ${run_dir}

# Best-Fit energy distributions
    Eres=6
    Eres_nl=0
    ./mkgnu_EventDistmin_combine.sh $P $V $R $Y 30 ${Eres} ${Eres_nl} ${run_dir}
###################################################################

elif [ ${mode} -eq 4 ]; then  # Free Analysis Plots
    if [ 1 -eq 1 ]; then
# Best-Fit energy distributions
	Eres=2
	Eres_nl=0
	./mkgnu_EventDistmin_combine_2.sh $P $V $R $Y 50 ${Eres} ${Eres_nl} ${run_dir}
	Eres_nl=0.5
	./mkgnu_EventDistmin_combine_2.sh $P $V $R $Y 50 ${Eres} ${Eres_nl} ${run_dir}
	Eres_nl=1
	./mkgnu_EventDistmin_combine_2.sh $P $V $R $Y 50 ${Eres} ${Eres_nl} ${run_dir}
	Eres=3
	Eres_nl=0
	./mkgnu_EventDistmin_combine_2.sh $P $V $R $Y 50 ${Eres} ${Eres_nl} ${run_dir}
	Eres_nl=0.5
	./mkgnu_EventDistmin_combine_2.sh $P $V $R $Y 50 ${Eres} ${Eres_nl} ${run_dir}
	Eres_nl=1
	./mkgnu_EventDistmin_combine_2.sh $P $V $R $Y 50 ${Eres} ${Eres_nl} ${run_dir}
    fi

    if [ 1 -eq 0 ]; then
	i=${Lmin}
	while [ $i -lt ${Lmaxp10} ]; do
	    ./mkgnu_EventDistmin.sh $P $V $R $Y $i 6 0 ${run_dir} 	
	    ./mkgnu_EventDistmin.sh $P $V $R $Y $i 5 0 ${run_dir}
	    ./mkgnu_EventDistmin.sh $P $V $R $Y $i 4 0 ${run_dir}
	    ./mkgnu_EventDistmin.sh $P $V $R $Y $i 3 0 ${run_dir}			
	    ./mkgnu_EventDistmin.sh $P $V $R $Y $i 2 0 ${run_dir}			
#	./mkgnu_adchi2.sh $P $V $R $Y $i	
	    i=`expr $i + 10`
	done
    fi

    if [ 1 -eq 0 ]; then
	./mkgnu_EventDist_combine.sh $P $V $R $Y 6 0 ${run_dir}
	./mkgnu_EventDist_combine.sh $P $V $R $Y 3 0 ${run_dir}
	./mkgnu_EventDist_combine.sh $P $V $R $Y 1.5 0 ${run_dir} 
	./mkgnu_EventDist_combine.sh $P $V $R $Y 0 0 ${run_dir}
    fi

    if [ 1 -eq 0 ]; then
# EventDist_combine with parameter description in title bar
     ./mkgnu_EventDist_combine_title.sh $P $V $R $Y 6 ${Eres_nl} ${run_dir}
     ./mkgnu_EventDist_combine_title.sh $P $V $R $Y 5 ${Eres_nl} ${run_dir}
     ./mkgnu_EventDist_combine_title.sh $P $V $R $Y 4 ${Eres_nl} ${run_dir} 
     ./mkgnu_EventDist_combine_title.sh $P $V $R $Y 3 ${Eres_nl} ${run_dir}
     ./mkgnu_EventDist_combine_title.sh $P $V $R $Y 2 ${Eres_nl} ${run_dir}
    fi

fi

cp -rf plots ${run_dir}/. 