#!/bin/bash
P=$1
V=$2
R=$3
Y=$4
Eres=$5
Eres_nl=$6
mode=$7
maxL_nh=$8
maxL_ih=$9
binsize=${10}
theta=${11}
nreactor=${12}

selfdir=$(cd $(dirname $0);pwd)

ifixL=0  # do not change
ifluc=0
#Lmin=${maxL_nh}
#Lmax=${maxL_ih}
Lmin=10
Lmax=100
ndiv=30
source ${selfdir}/dchi2_fitting_Eresnl.sh
#source ${selfdir}/dchi2_dist_onepoint.sh