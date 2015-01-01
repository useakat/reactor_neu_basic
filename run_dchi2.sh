#!/bin/bash
selfdir=$(cd $(dirname $0);pwd)

${selfdir}/dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres_a} ${Eres_b} ${mode} ${ifixL} ${ifluc} ${binsize_factor} ${ixsec} ${iPee}