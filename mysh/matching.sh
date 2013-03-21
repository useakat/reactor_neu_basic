#!/bin/bash

if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: matching.sh (mode) (xqcut) (qcutmin) (qcutmax) (step)"
    echo ""
    echo " [run] run name"
    echo " (mode) 0:serial, 1:pararell 2:multicore | 0"
    echo ""
    exit
fi

if [[ $1 != "" ]]; then
    mode=$1
else 
    echo "serial:0/pararell:1 ?"
    read mode
fi

if [[ $2 != "" ]]; then
    xqcut=$2
else 
    echo "xqcut?"
    read xqcut
fi
if [[ $3 != "" ]]; then
    qcutmin=$3
else 
    echo "qcut minimum?"
    read qcutmin
fi
if [[ $4 != "" ]]; then
    qcutmax=$4
else 
    echo "qcutmax?"
    read qcutmax
fi    
if [[ $5 != "" ]]; then
    step=$5
else 
    echo "step in qcuts?"
    read step
fi

sed -e "s/xqcut/aacut/" Cards/run_card.dat > run_tmp.dat
sed -e "/aacut/i  $xqcut   = xqcut   ! minimum kt jet measure between partons" run_tmp.dat > run_tmp2.dat
sed -e "/aacut/d" run_tmp2.dat > Cards/run_card.dat
rm run_tmp*

emacs Cards/run_card.dat

if [[ -e Cards/pythia_card.dat ]]; then
    echo > /dev/null
else 
    cp Cards/pythia_card_default.dat Cards/pythia_card.dat
fi

run=xq$xqcut
./bin/generate_events $mode $run $run
./qcutpy.sh $xqcut $qcutmin $qcutmax $step $mode

job="matching_"$name
bsub -J $job -u useakat@gmail.com nulljob.sh >/dev/null

