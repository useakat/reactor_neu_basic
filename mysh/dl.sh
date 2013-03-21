#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: dl.sh [path] [host]"
    echo ""
    echo " [path] path to the file to be downloaded"
    echo ""
    echo " [host] name or the adress of the host server with the login name"
    echo "        ex) user@host.com"
    exit
fi

path=$1
host=$2

if [[ $host == "heg" ]]; then
    scp -r yoshitar@heget.kek.jp:$path .
elif [[ $host == "kek" ]]; then
    scp -r takaesu@login.cc.kek.jp:$path .
elif [[ $host == "ing" ]]; then
    scp -r takaesu@ingrid-ui1.cism.ucl.ac.be:$path .
elif [[ $host == "ucl" ]]; then
    scp -r ytakaesu@server02.fynu.ucl.ac.be:$path .
else     
    scp -r $host:$path .
fi