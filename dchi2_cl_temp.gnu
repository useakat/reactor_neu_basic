set terminal postscript eps enhanced 'Times-Roman' color 20
#set logscale x
#set logscale y
#set format x '%L'
#set format y '%L'
#set xtics (0.001,0.01)
#set ytics (1,10,1E2)
#set tics scale 2
set grid
set key at graph 0.9,0.4
#set key spacing 1.5
#set xlabel 'cost' offset -1,0
#set ylabel 'log_{/=10 10} L (Mpc)' offset 1,0
set xrange [-4:60]
set yrange [0.6:1.03]
set mxtics 10
set mytics 5

set lmargin 8
set output 'plots/dchi2_cl.eps'
#set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years'
set title 'PPPGW_{th}, VVVkton (RRR% proton), ({/Symbol=\144}E_{vis}/E_{vis})^2 = (a %/ {/Symbol=\326}E_{vis})^2 + (b %)^2'
set ylabel '{/=25 C. L.}' offset 1,0
set xlabel '{/=25 ({/Symbol=\104}{/Symbol=\143}^2)_{min}}' offset -1,0
#set xlabel '{/=25 Years}' offset -1,0
set label '{/Symbol=\264}0.5' at 6.5,0.815 tc rgb 'red'
set label '{/Symbol=\264}1' at 12,0.91 tc rgb 'red'
set label '{/Symbol=\264}2' at 23,0.97 tc rgb 'red'
set label '{/Symbol=\264}3' at 34,0.98 tc rgb 'red'
set label '{/Symbol=\264}4' at 45,0.985 tc rgb 'red'
set label '{/Symbol=\264}5' at 56,0.985 tc rgb 'red'
set label '{/Symbol=\264}0.5' at -3,0.63 tc rgb 'blue'
set label '{/Symbol=\264}1' at 0.5,0.75 tc rgb 'blue'
set label '{/Symbol=\264}2' at 4,0.875 tc rgb 'blue'
set label '{/Symbol=\264}3' at 7,0.935 tc rgb 'blue'
set label '{/Symbol=\264}4' at 10.5,0.967 tc rgb 'blue'
set label '{/Symbol=\264}5' at 14,0.985 tc rgb 'blue'
set label '{/Symbol=\264}6' at 18,1 tc rgb 'blue'
set label '{/Symbol=\264}7' at 22,1.01 tc rgb 'blue'
set label '{/Symbol=\264}8' at 25,1.014 tc rgb 'blue'
set label '{/Symbol=\264}9' at 29,1.015 tc rgb 'blue'
set label '{/Symbol=\264}10' at 32,1.015 tc rgb 'blue'
#set label '3%' at 50,14
#set label '6%' at 50,9
#set yrange [0:210]
set pointsize 1.2
set multiplot
plot \
'DATADIR/dchi2_cl_nh_2_0.5.dat' u 1:3 t '(a, b) = (2, 0.5): NH'  w lp pointtype 7 lt 1 lc rgb 'red' lw 3 ,\
'DATADIR/dchi2_cl_ih_2_0.5.dat' u 1:3 t '                   IH'  w lp pointtype 6 lt 2 lc rgb 'red' lw 3 ,\
'DATADIR/dchi2_cl_nh_3_0.75.dat' every::0::10 u 1:3 t '        (3, 0.75): NH'  w lp pointtype 5 lt 1 lc rgb 'blue' lw 3 ,\
'DATADIR/dchi2_cl_ih_3_0.75.dat' every::0::10 u 1:3 t '                   IH'  w lp pointtype 4 lt 2 lc rgb 'blue' lw 3
set nomultiplot

reset
