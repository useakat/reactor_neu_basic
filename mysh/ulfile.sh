#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: ulfile.sh [file] [host]"
    echo ""
    echo " [file] file to be uploaded"
    echo " [host] name or the adress of the host server with the login name"
    echo "        ex) user@host.com"
    echo ""
    exit
fi

file=$1
host=$2

rmpath=$STUDY
path=`pwd`
dir=${path##${rmpath}/}

if [[ $host == "heg" ]]; then
    scp -r $file yoshitar@heget.kek.jp:/home/yoshitar/${dir}/.
elif [[ $host == "kek" ]]; then
    scp -r $file takaesu@login.cc.kek.jp:/home/th/takaesu/${dir}/.
elif [[ $host == "kekold" ]]; then
    scp -r $file takaesu@cw101.cc.kek.jp:/home/th/takaesu/${dir}/.
elif [[ $host == "ing" ]]; then
    scp -r $file takaesu@ingrid-ui1.cism.ucl.ac.be:/home/fynu/takaesu/${dir}/.
elif [[ $host == "ucl" ]]; then
    scp -r $file ytakaesu@server02.fynu.ucl.ac.be:/home/ytakaesu/${dir}/.
else
    scp -r $file $2:.
fi