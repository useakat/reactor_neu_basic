#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: run.sh [run_name]"
    echo ""
    exit
fi

if [[ $1 = "" ]]; then
    echo "input run name"
    read run
    echo "input reactor Power [GW]"
    read P
    echo "input baseline length [km]"
    read L
    echo "input detector volume [kton]"
    read V
    echo "input free proton fraction in the detector"
    read R 
    echo "input exposure time [year]"
    read Y   
else
    run=$1
    P=$2
    L=$3
    V=$4
    R=$5
    Y=$6
fi    

make clean >/dev/null 2>&1
rm -rf plots/*
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

make dist >/dev/null 2>&1
# plotting Figure 1, 2
./dist 1 $P 0 0 0 0.06

mv distxx.dat FluxXsec.dat
read norm < normxx.dat
./mkgnu_FluxXsec.sh 1 $P ${norm} 
gnuplot FluxXsec.gnu

mv dist_h.dat FluxXsec_h.dat
mv disth2.dat FluxXsec_h2.dat
read norm < norm_h.dat
./mkgnu_FluxXsec_h.sh 1 $P ${norm}
gnuplot FluxXsec_h.gnu

#plotting Figure 3
echo "" >> ${defout}
echo "[Naive Delta Chi^2 Extimation]" >> ${defout}
make eventdist >/dev/null 2>&1
i=10
while [ $i -ne 110 ]; do
    ./eventdist $i $P $V $R $Y

    echo "L =" $i "km" >> ${defout}
    cat deltachi2.txt >> ${defout}
    echo "" >> ${defout}

    mv evdist.dat events_${i}.dat
    mv edh6nh.dat events_6_nh_${i}.dat
    mv edh6ih.dat events_6_ih_${i}.dat
    mv edh3nh.dat events_3_nh_${i}.dat
    mv edh3ih.dat events_3_ih_${i}.dat
    mv edh1nh.dat events_1.5_nh_${i}.dat
    mv edh1ih.dat events_1.5_ih_${i}.dat

    i=`expr $i + 10`
done
read norm < norm.dat
./mkgnu_EventDist.sh $P $V $R $Y
gnuplot EventDist.gnu
Eres=6
./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
gnuplot EventDist_h.gnu
Eres=3
./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
gnuplot EventDist_h.gnu
Eres=1.5
./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
gnuplot EventDist_h.gnu

cp -rf plots ${run_dir}/. 

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