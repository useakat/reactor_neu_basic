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
theta=${10}
nreactor=${11}

selfdir=$(cd $(dirname $0);pwd)

ifixL=1  # do not change
ifluc=0
Lmin=${maxL_nh}
Lmax=${maxL_ih}
ndiv=10
source ${selfdir}/dchi2_fitting_Eresnl.sh