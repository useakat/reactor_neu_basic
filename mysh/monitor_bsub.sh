#!/bin/bash

if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: monitor_bsub.sh [job] [njob]"
    echo ""
    echo " [job] job name to be monitored"
    echo " [njob] the number of submitted jobs"
    echo ""
    exit
fi

t=$2

bjobs -J "$1" > jobstatus.dat
r=`grep RUN jobstatus.dat | wc -l`
w=`grep PEND jobstatus.dat | wc -l`
usus=`grep USUSP jobstatus.dat | wc -l`
psus=`grep PSUSP jobstatus.dat | wc -l`
ssus=`grep SSUSP jobstatus.dat | wc -l`
d=`expr $t - $r - $w - $usus - $psus - $ssus`

echo "waiting while finishing jobs on cluster"
while [[  $d -lt $t  ]]; do    
    echo $w $r $d $t
    sleep 10
    bjobs -J "$1" > jobstatus.dat
    r=`grep RUN jobstatus.dat | wc -l`
    w=`grep PEND jobstatus.dat | wc -l`
    usus=`grep USUSP jobstatus.dat | wc -l`
    psus=`grep PSUSP jobstatus.dat | wc -l`
    ssus=`grep SSUSP jobstatus.dat | wc -l`
    d=`expr $t - $r - $w - $usus - $psus - $ssus`
done
echo $w $r $d $t