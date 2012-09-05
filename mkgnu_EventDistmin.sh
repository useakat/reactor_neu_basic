#!/bin/bash

P=$1
V=$2
R=$3
Y=$4
L=$5

RR=`echo "scale=1; ${R}*100" | bc`

sed -e "s/PPP/${P}/" \
    -e "s/VVV/${V}/" \
    -e "s/RRR/${RR}/" \
    -e "s/LLL/${L}/" \
    -e "s/YYY/${Y}/" EventDistmin_temp.gnu > temp.gnu

if [ $L -eq 10 ]; then
    sed -e "s/YRANGE/set yrange [0:2E5]/" temp.gnu > temp2.gnu
elif [ $L -eq 20 ]; then
    sed -e "s/YRANGE/set yrange [0:4.5E4]/" temp.gnu > temp2.gnu
elif [ $L -eq 30 ]; then
    sed -e "s/YRANGE/set yrange [0:1.6E4]/" temp.gnu > temp2.gnu
elif [ $L -eq 40 ]; then
    sed -e "s/YRANGE/set yrange [0:7E3]/" temp.gnu > temp2.gnu
elif [ $L -eq 50 ]; then
    sed -e "s/YRANGE/set yrange [0:3E3]/" temp.gnu > temp2.gnu
elif [ $L -eq 60 ]; then
    sed -e "s/YRANGE/set yrange [0:2E3]/" temp.gnu > temp2.gnu
elif [ $L -eq 70 ]; then
    sed -e "s/YRANGE/set yrange [0:2.5E3]/" temp.gnu > temp2.gnu
elif [ $L -eq 80 ]; then
    sed -e "s/YRANGE/set yrange [0:2.5E3]/" temp.gnu > temp2.gnu
elif [ $L -eq 90 ]; then
    sed -e "s/YRANGE/set yrange [0:2.5E3]/" temp.gnu > temp2.gnu
elif [ $L -eq 100 ]; then
    sed -e "s/YRANGE/set yrange [0:2E3]/" temp.gnu > temp2.gnu
fi

mv temp2.gnu plot.gnu

gnuplot plot.gnu