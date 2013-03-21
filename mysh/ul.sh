#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: ul.sh [path] [host]"
    echo ""
    echo " [path] path to the file to be uploaded"
    echo " [host] name or the adress of the host server with the login name"
    echo "        ex) user@host.com"
    echo ""
    exit
fi

path=$1
host=$2

if [[ $host == "heg" ]]; then
    scp -r $path yoshitar@heget.kek.jp:.
elif [[ $host == "kek" ]]; then
    scp -r $path takaesu@login.cc.kek.jp:.
elif [[ $host == "ing" ]]; then
    scp -r $path takaesu@ingrid-ui1.cism.ucl.ac.be:.
elif [[ $host == "ucl" ]]; then
    scp -r $path ytakaesu@server02.fynu.ucl.ac.be:.
else
    scp -r $path $2:.
fi