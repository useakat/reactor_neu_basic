#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)

${selfdir}/dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres_a} ${Eres_b} ${mode} 0 ${ifixL} ${ifluc} ${binsize_factor} ${theta} ${nreactor} $xx $yy ${reactor_mode} ${reactor_type} ${ixsec} ${iPee}