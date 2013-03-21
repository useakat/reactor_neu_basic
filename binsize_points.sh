#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)

binsize=0.06
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.055
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.05
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.045
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.04
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.035
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.03
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.025
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.02
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.015
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.01
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.005
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}
binsize=0.0025
source ${selfdir}/dchi2_dist_onepoint.sh
read line < dchi2_dist_nh.dat
echo ${binsize} ${line} >> ${output}