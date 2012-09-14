#!/bin/bash

P=20
V=5
R=0.05
Y=5

    i=10
    while [ $i -ne 110 ]; do
	./mkgnu_EventDistmin.sh $P $V $R $Y $i	
	i=`expr $i + 10`
    done