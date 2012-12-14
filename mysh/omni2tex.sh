#!/bin/bash

dir=$STUDY/projects/PhD_thesis/PhDThesis_tex.tex
file=main.tex

sed "s/chapter{TC:\(.*\)}/chapter{\1}/" $dir/$file > $dir/tmp.tex
sed "s/chapter{C:\(.*\)}/chapter{\1}/" $dir/tmp.tex > $dir/tmp1.tex
sed "s/section{TSec:\(.*\)}/section{\1}/" $dir/tmp1.tex > $dir/tmp.tex
sed "s/section{S:\(.*\)}/section{\1}/" $dir/tmp.tex > $dir/tmp1.tex
sed "s/subsection{SS:\(.*\)}/subsection{\1}/" $dir/tmp1.tex > $dir/tmp.tex
sed "s/SSS:\(.*\)/\\\\subsubsection{\1}/" $dir/tmp.tex > $dir/tmp1.tex

sed "/^$/d" $dir/tmp1.tex > $dir/tmp.tex
sed "s/a/a/" $dir/tmp.tex > $dir/tmp1.tex
sed "s/\\\\\\section{TP:\(.*\)}//" $dir/tmp1.tex > $dir/tmp.tex
sed "s/\\\\\\section{P:\(.*\)}//" $dir/tmp.tex > $dir/tmp1.tex
sed "s/\\\\\\subsection{TP:\(.*\)}//" $dir/tmp1.tex > $dir/tmp.tex
sed "s/\\\\\\subsection{P:\(.*\)}//" $dir/tmp.tex > $dir/tmp1.tex
sed "s/\\\\\\section{Fig:\(.*\)}/\1./" $dir/tmp1.tex > $dir/tmp.tex
sed "s/\\\\\\subsection{Fig:\(.*\)}/\1./" $dir/tmp.tex > $dir/tmp1.tex
sed "s/\\\\\\section{Table:\(.*\)}/\1./" $dir/tmp1.tex > $dir/tmp.tex
sed "s/\\\\\\subsection{Table:\(.*\)}/\1./" $dir/tmp.tex > $dir/tmp1.tex

#sed '/chapter/a %' $dir/tmp.tex > $dir/tmp1.tex
sed "s/a/a/" $dir/tmp1.tex > $dir/tmp.tex

sed "s/TP:\(.*\)/\1.\\\\\\\\/" $dir/tmp.tex > $dir/tmp1.tex
sed "s/P:\(.*\)/\* \1\\\\\\\\/" $dir/tmp1.tex > $dir/tmp.tex
sed "s/TS:\(.*\)/\1/" $dir/tmp.tex > $dir/tmp1.tex
sed "s/chapter{References::}/begin{thebibliography}{00}/" $dir/tmp1.tex > $dir/tmp.tex
sed "s/endref/\\\\\\end{thebibliography}/" $dir/tmp.tex > $dir/tmp1.tex

sed "s/Maketitle::/\\\\\\maketitle/" $dir/tmp1.tex > $dir/tmp.tex

sed "s/chapter{Abstract::}/abstract{/" $dir/tmp.tex > $dir/tmp1.tex
sed "s/ABSE/}/" $dir/tmp1.tex > $dir/tmp.tex

sed "s/Contents::/\\\\\\tableofcontents/" $dir/tmp.tex > $dir/tmp1.tex

sed "s/ITB/\\\\\\begin{itemize}/" $dir/tmp1.tex > $dir/tmp.tex
sed "s/IT:/\\\\\\item /" $dir/tmp.tex > $dir/tmp1.tex
sed "s/ITE/\\\\\\end{itemize}/" $dir/tmp1.tex > $dir/2$file

