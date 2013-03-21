#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: rsync_push.sh [type]"
    echo ""
    exit
fi

rmpath=$STUDY
path=`pwd`
dir=${path##${rmpath}/}

echo `date '+%s'` > date.txt
rsync -avzr --delete -e ssh ./ yoshitar@heget.kek.jp:/home/yoshitar/${dir}