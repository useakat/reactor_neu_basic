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
if [ -e ${run_dir} ]; then
    rm -rf ${run_dir}/*
else
    mkdir ${run_dir}
fi

echo ${date} ${ttime} > ${run_dir}/summary.txt

### start program ###

echo "" >> ${run_dir}/summary.txt
echo "[Parameters]" >> ${run_dir}/summary.txt
echo "Reactor Power:" $P "GW_{th}" >> ${run_dir}/summary.txt
echo "Detector Volume:" $V "kton" >> ${run_dir}/summary.txt
echo "Free Proton Weight Fraction:" $R >> ${run_dir}/summary.txt
echo "Exposure time:" $Y "year" >> ${run_dir}/summary.txt

make basic_plots >/dev/null 2>&1

make dist >/dev/null 2>&1
# plotting Figure 1, 2
./dist 1 $P 0 0 0 0.06

mv distxx.dat FluxXsec.dat
./mkgnu_FluxXsec.sh 1 $P
gnuplot FluxXsec.gnu

mv dist_h.dat FluxXsec_h.dat
mv disth2.dat FluxXsec_h2.dat
./mkgnu_FluxXsec_h.sh 1 $P
gnuplot FluxXsec_h.gnu

#plotting Figure 3
make eventdist >/dev/null 2>&1
i=10
while [ $i -ne 110 ]; do
    ./eventdist $i $P $V $R $Y
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
#norm=2
./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
gnuplot EventDist_h.gnu
Eres=3
#norm=2
./mkgnu_EventDist_h.sh $P $V $R $Y ${Eres} ${norm}
gnuplot EventDist_h.gnu
Eres=1.5
#norm=2
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

echo "" >> ${run_dir}/summary.txt
echo "total time = " $elapsed_time >> ${run_dir}/summary.txt

echo ""
echo `date '+%T'`