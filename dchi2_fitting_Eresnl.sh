#!/bin/bash
    ./dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} $Eres_nl} ${mode} 0 ${ifixL}
    mv dchi2min_nh.dat dchi2min_nh_${Eres}_${Eres_nl}.dat
    mv dchi2min_ih.dat dchi2min_ih_${Eres}_${Eres_nl}.dat
    mv dchi2min_bestfit2ih.dat dchi2min_bestfit2ih_${Eres}_${Eres_nl}.dat
    mv dchi2min_bestfit2nh.dat dchi2min_bestfit2nh_${Eres}_${Eres_nl}.dat