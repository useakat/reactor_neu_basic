#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: dlfile.sh [file] [host]"
    echo ""
    echo " [file] the file to be downloaded"
    echo ""
    echo " [host] name or the adress of the host server with the login name"
    echo "        ex) user@host.com"
    exit
fi

file=$1

rmpath=$STUDY
path=`pwd`
dir=${path##${rmpath}/}

if [[ "$1" == "heg" ]]; then
    scp -r yoshitar@heget.kek.jp:/home/yoshitar/${dir}/$file .
elif [[ "$1" == "kek" ]]; then
    scp -r takaesu@login.cc.kek.jp:/home/th/takaesu/${dir}/$file .
elif [[ "$1" == "kekold" ]]; then
    scp -r takaesu@cw101.cc.kek.jp:/home/th/takaesu/${dir}/$file .
elif [[ "$1" == "ing" ]]; then
    scp -r takaesu@ingrid-ui1.cism.ucl.ac.be:/home/fynu/takaesu/${dir}/$file .
elif [[ "$1" == "ucl" ]]; then
    scp -r ytakaesu@server02.fynu.ucl.ac.be:/home/ytakaesu/${dir}/$file .
else     
    scp -r $2:$file .
fi