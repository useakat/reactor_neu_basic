#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: tarul.sh [path] [host]"
    echo ""
    echo " [path] path to the file to be uploaded"
    echo " [host] name or the adress of the host server with the login name"
    echo "        ex) user@host.com"
    echo ""
    exit
fi

path=$1
host=$2

file=${path##*/}

tar cvf ${file}.tar $path
ul.sh ${file}.tar $host
rm ${file}.tar