#!/bin/bash

    ifixL=0
    ifluc=0
    Lmin=10
    ndiv=100
    source dchi2_fitting_Eresnl.sh
    source get_dchi2max.sh
    echo $maxline_nh $maxL_nh $dchi2max_nh > dchi2max_nh_${Eres}_${Eres_nl}.dat
    echo $maxline_ih $maxL_ih $dchi2max_ih > dchi2max_ih_${Eres}_${Eres_nl}.dat
    ifixL=1
    ifluc=1
    Lmin=${maxL_nh}
    ndiv=100
    source dchi2_fitting_Eresnl.sh