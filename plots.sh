#!/bin/bash
if [[ $1 = "" ]]; then
    echo "input run name"
    read run
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
    read run
    echo "input Lmax"
    read run  
    echo "input mode"
    read mode  
else
    run=$1
#P=$2
#V=$3
#R=$4
#Y=$5
#    Eres=$2
    Lmin=$2
    Lmax=$3
    mode=$4
fi

P=20
V=5
R=0.12
Y=5

norm=1
fit_mode=-1
Lmaxp10=`expr ${Lmax} + 10`
run_dir=rslt_${run}

if [ ${mode} -eq 1 ]; then
    ./mkgnu_FluxXsec.sh ${Lmin} $P ${norm} 
    ./mkgnu_FluxXsec_h.sh ${Lmin} $P ${norm}
    i=${Lmin}
    while [ $i -lt ${Lmaxp10}  ]; do
	./mkgnu_FvsLoE.sh $i $P ${norm} 
	./mkgnu_FvsE.sh $i $P
	i=`expr $i + 10`
    done

elif [ ${mode} -eq 2 ]; then
    ./mkgnu_EventDist.sh $P $V $R $Y
#     norm=2
#     Eres=6
#     ./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
#     Eres=3
#     ./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
#     Eres=1.5
#     ./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}

elif [ ${mode} -eq 3 ]; then
#    ./mkgnu_dchi2.sh $P $V $R $Y 6
#    ./mkgnu_dchi2.sh $P $V $R $Y 3
#    ./mkgnu_dchi2.sh $P $V $R $Y 1.5
    i=${Lmin}
    while [ $i -lt ${Lmaxp10} ]; do
	./mkgnu_EventDistmin.sh $P $V $R $Y $i 6	
	./mkgnu_EventDistmin.sh $P $V $R $Y $i 3
	./mkgnu_EventDistmin.sh $P $V $R $Y $i 1.5
	./mkgnu_EventDistmin.sh $P $V $R $Y $i 0			
#	./mkgnu_adchi2.sh $P $V $R $Y $i	
	i=`expr $i + 10`
    done
    ./mkgnu_dchi2_combine.sh $P $V $R $Y ${fit_mode}
    ./mkgnu_EventDist_combine.sh $P $V $R $Y 6
    ./mkgnu_EventDist_combine.sh $P $V $R $Y 3
    ./mkgnu_EventDist_combine.sh $P $V $R $Y 1.5
    ./mkgnu_EventDist_combine.sh $P $V $R $Y 0

fi

cp -rf plots ${run_dir}/. 