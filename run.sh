#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: run.sh [run_name] [Power] [Volume] [Proton Ratio] [Year] [run mode]"
    echo ""
    exit
fi

if [[ $1 = "" ]]; then
    echo "input run name"
    read run
    echo "input reactor Power [GW]"
    read P
#    echo "input baseline length [km]"
#    read L
    echo "input detector volume [kton]"
    read V
    echo "input free proton fraction in the detector"
    read R 
    echo "input exposure time [year]"
    read Y   
    echo "input run mode: 0:All 1:Flux*Xsec 2:dN/dE 3:del-chi2"
    read run_mode  
else
    run=$1
    P=$2
    V=$3
    R=$4
    Y=$5
    run_mode=$6
fi    

make clean >/dev/null 2>&1
rm -rf plots/*
rm *.dat
start_time=`date '+%s'`
date=`date '+%Y/%m/%d'`
ttime=`date '+%T'`
echo ${date} ${ttime}

run_dir=rslt_${run}
defout=${run_dir}/summary.txt

if [ -e ${run_dir} ]; then
    rm -rf ${run_dir}/*
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
Lmin=10
Lmax=100
ndiv=100
Eres=6

if [ ${run_mode} -eq 1 ] || [ ${run_mode} -eq 0 ] ; then  # plotting Flux*Xsec
    norm=1

    mode=1
    Lmin=1
    ./dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}

    mode=3
    i=10
    while [ $i -lt 110 ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
	mv FluxXsec_loe.dat FluxXsec_loe_${i}.dat
	mv FluxXsecPeeNH_loe.dat FluxXsecPeeNH_loe_${i}.dat
	mv FluxXsecPeeIH_loe.dat FluxXsecPeeIH_loe_${i}.dat
	mv PeeNH_loe.dat PeeNH_loe_${i}.dat
	mv PeeIH_loe.dat PeeIH_loe_${i}.dat
	i=`expr $i + 10`
    done

    mode=4
    i=10
    while [ $i -lt 110 ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
	mv PeeNH.dat PeeNH_${i}.dat
	mv PeeIH.dat PeeIH_${i}.dat
	i=`expr $i + 10`
    done
fi    
if [ ${run_mode} -eq 2 ] || [ ${run_mode} -eq 0 ]; then  #plotting dN/dE
    mode=2
    i=10
    while [ $i -lt 110 ]; do
	Eres=6
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
	mv evdinh.dat events_nh_${i}.dat
	mv evdiih.dat events_ih_${i}.dat
#	mv edh6nh.dat events_6_nh_${i}.dat
#	mv edh6ih.dat events_6_ih_${i}.dat
	
# 	Eres=3
# 	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
# 	mv edh6nh.dat events_3_nh_${i}.dat
# 	mv edh6ih.dat events_3_ih_${i}.dat
	
# 	Eres=1.5
# 	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
# 	mv edh6nh.dat events_1.5_nh_${i}.dat
# 	mv edh6ih.dat events_1.5_ih_${i}.dat
	
	i=`expr $i + 10`
    done

fi


if [ ${run_mode} -eq 3 ] || [ ${run_mode} -eq 0 ]; then  # Plotting Delta-Chi2 vs. L
    mode=0
    Eres=6
    ./dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
    mv dchi2min_nh.dat dchi2min_nh_${Eres}.dat
    mv dchi2min_ih.dat dchi2min_ih_${Eres}.dat
    mv dchi2min_bestfit2ih.dat dchi2min_bestfit2ih_${Eres}.dat
    mv dchi2min_bestfit2nh.dat dchi2min_bestfit2nh_${Eres}.dat
    Eres=3
    ./dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
    mv dchi2min_nh.dat dchi2min_nh_${Eres}.dat
    mv dchi2min_ih.dat dchi2min_ih_${Eres}.dat
    mv dchi2min_bestfit2ih.dat dchi2min_bestfit2ih_${Eres}.dat
    mv dchi2min_bestfit2nh.dat dchi2min_bestfit2nh_${Eres}.dat
    Eres=1.5
    ./dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
    mv dchi2min_nh.dat dchi2min_nh_${Eres}.dat
    mv dchi2min_ih.dat dchi2min_ih_${Eres}.dat
    mv dchi2min_bestfit2ih.dat dchi2min_bestfit2ih_${Eres}.dat
    mv dchi2min_bestfit2nh.dat dchi2min_bestfit2nh_${Eres}.dat

#################  Best Fit Plots and Data #####################
    mode=2
    Lmaxp10=`expr ${Lmax} + 10`
    
    Eres=6
    mv dchi2min_bestfit2nh_${Eres}.dat dchi2min_bestfit2nh.dat
    mv dchi2min_bestfit2ih_${Eres}.dat dchi2min_bestfit2ih.dat
    touch int_adchi2_fit2nh_${Eres}.dat
    touch int_adchi2_fit2ih_${Eres}.dat
    i=${Lmin}
    while [ $i -lt ${Lmaxp10} ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
	mv evdinh.dat events_nh_${i}_${Eres}.dat
	mv evdiih.dat events_ih_${i}_${Eres}.dat
	mv evdiihmin.dat events_ihmin_${i}_${Eres}.dat
	mv evdinhmin.dat events_nhmin_${i}_${Eres}.dat
#       	mv event_min2nh.dat ${run_dir}/events_fit2nh_${i}_${Eres}.txt
#       	mv event_min2ih.dat ${run_dir}/events_fit2ih_${i}_${Eres}.txt
	mv adchi2_fit2nh.dat adchi2_fit2nh_${i}_${Eres}.dat
	mv adchi2_fit2ih.dat adchi2_fit2ih_${i}_${Eres}.dat
	read int_adchi2 < int_adchi2_fit2nh.dat 
	echo $i ${int_adchi2} >> int_adchi2_fit2nh_${Eres}.dat
	read int_adchi2 < int_adchi2_fit2ih.dat 
	echo $i ${int_adchi2} >> int_adchi2_fit2ih_${Eres}.dat
	i=`expr $i + 10`
    done
    Eres=3
    mv dchi2min_bestfit2nh_${Eres}.dat dchi2min_bestfit2nh.dat
    mv dchi2min_bestfit2ih_${Eres}.dat dchi2min_bestfit2ih.dat
    touch int_adchi2_fit2nh_${Eres}.dat
    touch int_adchi2_fit2ih_${Eres}.dat
    i=${Lmin}
    while [ $i -lt ${Lmaxp10} ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
	mv evdinh.dat events_nh_${i}_${Eres}.dat
	mv evdiih.dat events_ih_${i}_${Eres}.dat
	mv evdiihmin.dat events_ihmin_${i}_${Eres}.dat
	mv evdinhmin.dat events_nhmin_${i}_${Eres}.dat
#       	mv event_min2nh.dat ${run_dir}/events_fit2nh_${i}_${Eres}.txt
#       	mv event_min2ih.dat ${run_dir}/events_fit2ih_${i}_${Eres}.txt
	mv adchi2_fit2nh.dat adchi2_fit2nh_${i}_${Eres}.dat
	mv adchi2_fit2ih.dat adchi2_fit2ih_${i}_${Eres}.dat
	read int_adchi2 < int_adchi2_fit2nh.dat 
	echo $i ${int_adchi2} >> int_adchi2_fit2nh_${Eres}.dat
	read int_adchi2 < int_adchi2_fit2ih.dat 
	echo $i ${int_adchi2} >> int_adchi2_fit2ih_${Eres}.dat
	i=`expr $i + 10`
    done
    Eres=1.5
    mv dchi2min_bestfit2nh_${Eres}.dat dchi2min_bestfit2nh.dat
    mv dchi2min_bestfit2ih_${Eres}.dat dchi2min_bestfit2ih.dat
    touch int_adchi2_fit2nh_${Eres}.dat
    touch int_adchi2_fit2ih_${Eres}.dat
    i=${Lmin}
    while [ $i -lt ${Lmaxp10} ]; do
	./dchi2 $i $Lmax $ndiv $P $V $R $Y ${Eres} ${mode}
	mv evdinh.dat events_nh_${i}_${Eres}.dat
	mv evdiih.dat events_ih_${i}_${Eres}.dat
	mv evdiihmin.dat events_ihmin_${i}_${Eres}.dat
	mv evdinhmin.dat events_nhmin_${i}_${Eres}.dat
#       	mv event_min2nh.dat ${run_dir}/events_fit2nh_${i}_${Eres}.txt
#       	mv event_min2ih.dat ${run_dir}/events_fit2ih_${i}_${Eres}.txt
	mv adchi2_fit2nh.dat adchi2_fit2nh_${i}_${Eres}.dat
	mv adchi2_fit2ih.dat adchi2_fit2ih_${i}_${Eres}.dat
	read int_adchi2 < int_adchi2_fit2nh.dat 
	echo $i ${int_adchi2} >> int_adchi2_fit2nh_${Eres}.dat
	read int_adchi2 < int_adchi2_fit2ih.dat 
	echo $i ${int_adchi2} >> int_adchi2_fit2ih_${Eres}.dat
	i=`expr $i + 10`
    done

    echo "" >> ${defout}
    cat dchi2_result.txt >> ${defout}
fi    

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