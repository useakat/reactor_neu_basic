#!/bin/bash
for fn in tmp/*.txt; do 
    cdir=${fn}
    cdir=${cdir%.txt}
    cdir=${cdir#tmp/}
done
cp -r tmp $cdir
rm $cdir/*.txt 
rm tmp/*.txt 
rm tmp/Events/*