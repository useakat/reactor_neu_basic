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
#set xrange [-4:60]
#set yrange [0.6:1.03]
set mxtics 10
set mytics 5

set lmargin 8
set output 'plots/dchi2_sigma.eps'
#set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years'
set title 'PPPGW_{th}, VVVkton (RRR% proton), ({/Symbol=\144}E_{vis}/E_{vis})^2 = (a %/ {/Symbol=\326}E_{vis})^2 + (b %)^2'
set ylabel '{/=25 C. L.}' offset 1,0
set xlabel '{/=25 ({/Symbol=\104}{/Symbol=\143}^2)_{min}}' offset -1,0
#set xlabel '{/=25 Years}' offset -1,0
#set label '3%' at 50,14
#set label '6%' at 50,9
#set yrange [0:210]
set pointsize 1.2
set multiplot
plot \
'DATADIR/dchi2_cl_nh_2_0.5.dat' u 1:4 t '(a, b) = (2, 0.5): NH'  w lp pointtype 7 lt 1 lc rgb 'red' lw 3 ,\
'DATADIR/dchi2_cl_ih_2_0.5.dat' u 1:4 t '                   IH'  w lp pointtype 6 lt 2 lc rgb 'red' lw 3 ,\
'DATADIR/dchi2_cl_nh_3_0.75.dat' every::0::10 u 1:4 t '        (3, 0.75): NH'  w lp pointtype 5 lt 1 lc rgb 'blue' lw 3 ,\
'DATADIR/dchi2_cl_ih_3_0.75.dat' every::0::10 u 1:4 t '                   IH'  w lp pointtype 4 lt 2 lc rgb 'blue' lw 3
set nomultiplot

reset
