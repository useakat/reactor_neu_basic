#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)

${selfdir}/dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres} ${Eres_nl} ${mode} 0 ${ifixL} ${ifluc} ${binsize} ${theta} ${nreactor} $xx $yy ${reactor_mode} ${reactor_type} ${ixsec} ${iPee}