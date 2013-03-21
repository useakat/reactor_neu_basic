#!/bin/bash

dir=~/Dropbox/Documents/PostdocApplication
file=ResearchInterest.tex

sed "s/Maketitle::/\\\\\\maketitle/" $dir/$file > $dir/tmp.tex