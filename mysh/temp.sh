#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: temp.sh [file type] [filename]"
    echo ""
    echo " [file type] template type: fpro,fsub,sh"
    echo ""
    echo " [filename] file name"
    echo ""
    exit
fi

type=$1
filename=$2

if [ $type == "fsub" ]; then
    file=subroutine_temp.f
elif [ $type == "fpro" ]; then
    file=program_temp.f
elif [ $type == "fmake" ]; then
    file=Makefile_temp.f
elif [ $type == "sh" ]; then
    file=sh_temp.sh
else
    echo "invalid file type"
    exit
fi
cp $STUDY/templates/$file tmp.dat
filename2=${filename%.*}
sed "s/main/$filename2/" tmp.dat > $filename
rm tmp.dat
emacs -nw $filename