#!/bin/bash
cd $1
for fn in *.ps; do
    file=${fn%.ps}
    mv ${fn} ${file}.eps
done