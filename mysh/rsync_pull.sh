#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: rsync_pull.sh [type]"
    echo ""
    exit
fi

server=yoshitar@heget.kek.jp
server_home=/home/yoshitar
rmpath=$STUDY
path=`pwd`
dir=${path##${rmpath}/}
dir2=${path##*/}

cd ..
cp -r $dir2 ${dir2}_bk
cd $dir2
ssh ${server} cat ${dir}/date.txt > date_server.txt
read local_date < date.txt
read server_date < date_server.txt
if [ ${local_date} -lt ${server_date} ];then
    rsync -avzr --delete -e ssh ${server}:${server_home}/${dir} ../
else
    echo "your version is the latest. Not pulled"
fi