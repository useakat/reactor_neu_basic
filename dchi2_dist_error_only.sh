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

selfdir=$(cd $(dirname $0);pwd)

ifixL=1
ifluc=1
Lmin=${maxL_nh}
Lmax=${maxL_ih}
ndiv=10000
source ${selfdir}/dchi2_fitting_Eresnl.sh
source ${selfdir}/get_cl.sh