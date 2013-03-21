#!/bin/bash
i=1
dchi2max=0
while read line; do
    L=`echo $line | cut -d' ' -f 1`
    dchi2=`echo $line | cut -d' ' -f 2`
    x=$(echo "scale=3;if( ${dchi2} > ${dchi2max} ) 1 else 0" | bc)
    if [ $x = 1 ];then
	dchi2max=${dchi2}
	maxL=$L
	maxline=$i
    fi
    i=`expr $i + 1`
done < dchi2min_nh_${Eres}_${Eres_nl}.dat
dchi2max_nh=${dchi2max}
maxL_nh=${maxL}
maxline_nh=${maxline}

i=1
dchi2max=0
while read line; do
    L=`echo $line | cut -d' ' -f 1`
    dchi2=`echo $line | cut -d' ' -f 2`
    x=$(echo "scale=3;if( ${dchi2} > ${dchi2max} ) 1 else 0" | bc)
    if [ $x = 1 ];then
	dchi2max=${dchi2}
	maxL=$L
	maxline=$i
    fi
    i=`expr $i + 1`
done < dchi2min_ih_${Eres}_${Eres_nl}.dat
dchi2max_ih=${dchi2max}
maxL_ih=${maxL}
maxline_ih=${maxline}