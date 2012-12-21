set terminal postscript eps enhanced 'Times-Roman' color 20
#set logscale x
set logscale y
#set format x '%L'
set format y '10^{%L}'
#set xtics (0.001,0.01)
#set ytics (1,10,1E2)
#set tics scale 2
set grid
set key at graph 0.97,0.685
#set key spacing 1.5
#set xlabel 'cost' offset -1,0
#set ylabel 'log_{/=10 10} L (Mpc)' offset 1,0
#set xrange [0:10]
set yrange [1E-7:1]
set mxtics 10
set mytics 5

n=10
set lmargin 8
set output 'plots/dchi2_sigma.eps'
#set title 'P_{reactor} = 20GW_{th}, V = 5kton (12.00% free proton), 10 years'
#set title '20GW_{th}, 5kton (12.00% proton), ({/Symbol=\144}E_{vis}/E_{vis})^2 = (a %/ {/Symbol=\326}E_{vis})^2 + (b %)^2'
set ylabel '{/=25 1 - P}' offset 0,0
set xlabel '{/=25 {/Symbol=\326}({/Symbol=\104}{/Symbol=\143}^2)_{min}}' offset -1,0
#set xlabel '{/=25 Years}' offset -1,0
set label '1{/Symbol=\163}' at n,0.3173 offset 0.5,0
set label '2{/Symbol=\163}' at n,0.0455 offset 0.5,0
set label '3{/Symbol=\163}' at n,0.0027 offset 0.5,0
set label '4{/Symbol=\163}' at n,0.000063 offset 0.5,0
set label '5{/Symbol=\163}' at n,0.00000057 offset 0.5,0
set label '6{/Symbol=\163}' at n,0.000000002 offset 0.5,0
#set label '6%' at 50,9
#set yrange [0:210]
set pointsize 1.2
set multiplot
plot \
'rslt_test/data/dchi2_cl_nh_2_0.5.dat' every::2::7 u (sqrt($1)):(1-$3) t '(a, b) = (2, 0.5): NH'  w lp pointtype 7 lt 1 lc rgb 'red' lw 3 ,\
'rslt_test/data/dchi2_cl_ih_2_0.5.dat' every::2::7 u (sqrt($1)):(1-$3) t '                   IH'  w lp pointtype 6 lt 2 lc rgb 'red' lw 3 ,\
'rslt_test/data/dchi2_cl_nh_3_0.75.dat' every::2::7 u (sqrt($1)):(1-$3) t '        (3, 0.75): NH'  w lp pointtype 5 lt 1 lc rgb 'blue' lw 3 ,\
'rslt_test/data/dchi2_cl_ih_3_0.75.dat' every::2::7  u (sqrt($1)):(1-$3) t '                   IH'  w lp pointtype 4 lt 2 lc rgb 'blue' lw 3 ,\
'rslt_test/data/dchi2_cl_nostat.dat' u (sqrt($1)):(1-$2) t 'No Fluctuation'  w l lt 1 lc rgb 'black' lw 5 ,\
0.3173 notitle w l lt 2 lc rgb 'black' lw 3 ,\
0.0455 notitle w l lt 2 lc rgb 'black' lw 3 ,\
0.0027 notitle w l lt 2 lc rgb 'black' lw 3 ,\
0.000063 notitle w l lt 2 lc rgb 'black' lw 3 ,\
0.00000057 notitle w l lt 2 lc rgb 'black' lw 3 ,\
0.000000002 notitle w l lt 2 lc rgb 'black' lw 3
set nomultiplot

reset
