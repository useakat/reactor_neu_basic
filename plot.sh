#!/bin/bash

P=20
V=5
R=0.12
Y=5
Eres=6
i=10

./mkgnu_dchi2.sh $P $V $R $Y ${Eres}
./mkgnu_adchi2.sh $P $V $R $Y $i	
