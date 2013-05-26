#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)

ifixL=1  # do not change
ifluc=0
Lmin=${maxL_nh}
Lmax=${maxL_ih}
ndiv=10
source ${selfdir}/dchi2_fitting_Eresnl.sh
#source ${selfdir}/get_cl.sh