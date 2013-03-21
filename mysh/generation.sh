#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: generation.sh [run] (mode) (it)"
    echo ""
    echo " [run] run name"
    echo " (mode) 0:serial, 1:pararell 2:multicore | 0"
    echo ""
    exit
fi

if [[ "$2" == "" ]]; then
    p=0
else 
    p=$2
fi

if [[ "$3" == "" ]]; then
    it=1
else
    it=$3
fi

i=0
while [ $i -ne $it ]
do
  if [[ $it -eq 1 ]]; then
      name=$1
  else
      name="$1_$i"
  fi
  ./bin/generate_events $2 $name $name
  i=`expr $i + 1`
done
