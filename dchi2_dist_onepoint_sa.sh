#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)

Lmin=$1
Lmax=$2
ndiv=$3
P=$4
V=$5
R=$6
Y=$7
Eres=$8
Eres_nl=$9
mode=${10}
ifixL=${12}
ifluc=${13}
binsize=${14}
theta=${15}
nreactor=${16}
xx=${17}
yy=${18}
reactor_mode=${19}
reactor_type=${20}
ixsec=${21}

source ${selfdir}/dchi2_fitting_Eresnl.sh
#source ${selfdir}/get_cl.sh