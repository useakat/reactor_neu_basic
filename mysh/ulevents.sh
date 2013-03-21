#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: event2heg.sh [server] [xqcut] [qcut] [number_start] [number_end]"
    exit
fi

serv=$1
xqcut=$2
qcut=$3
i=$4
endp1=`expr $5 + 1`

dir=ulevnt
mkdir $dir
while [[ $i -ne $endp1 ]]; do
    cp Events/xq${xqcut}_${i}_q${qcut}_pythia_lhe_events.root ${dir}/.
    i=`expr $i + 1`
done

tarfile=xq${xqcut}_q${qcut}_pythia_lhe_$4_$5.tar
tar cvf $tarfile $dir
ul.sh $tarfile $serv .
rm -r $dir $tarfile