#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)
    ${selfdir}/dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 ${ifixL} ${ifluc} ${binsize} ${theta} ${nreactor}
    if [ ${ifixL} -eq 0 ];then
	mv dchi2min_nh.dat dchi2min_nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_ih.dat dchi2min_ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_bestfit2ih.dat dchi2min_bestfit2ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_bestfit2nh.dat dchi2min_bestfit2nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2_multi_nh.dat dchi2_multi_nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2_multi_ih.dat dchi2_multi_ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
    else
	mv dchi2min_nh.dat dchi2min_nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_ih.dat dchi2min_ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_bestfit2ih.dat dchi2min_bestfit2ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2min_bestfit2nh.dat dchi2min_bestfit2nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2_dist_nh.dat dchi2_dist_nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2_dist_ih.dat dchi2_dist_ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2_error_nh.dat dchi2_error_nh_${Eres}_${Eres_nl}.dat
	mv dchi2_error_ih.dat dchi2_error_ih_${Eres}_${Eres_nl}.dat
	mv sensitivity_error_nh.dat sensitivity_error_nh_${Eres}_${Eres_nl}.dat
	mv sensitivity_error_ih.dat sensitivity_error_ih_${Eres}_${Eres_nl}.dat
	mv dchi2_multi_nh.dat dchi2_multi_nh_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
	mv dchi2_multi_ih.dat dchi2_multi_ih_${Eres}_${Eres_nl}.dat >/dev/null 2>&1
    fi