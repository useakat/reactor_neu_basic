set terminal postscript eps enhanced 'Times-Roman' color 17
#set logscale x
#set logscale y
#set format x '%L'
#set format y '%L'
#set xtics (0.001,0.01)
#set ytics (1,10,1E2)
#set tics scale 2
set grid
#set key at 1.0E3,1.0E7 samplen 2
#set key spacing 1.5
#set xlabel 'cost' offset -1,0
#set ylabel 'log_{/=10 10} L (Mpc)' offset 1,0
#set xrange [-1:1]
#set yrange [1E-5:2E8]

set output 'plots/dchi2_ERES.eps'
set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, {/Symbol=\144}E_{vis}/E_{vis} = ERES%/{/Symbol=\326}E_{vis}'
set ylabel '{/Symbol=\104}{/Symbol=\143}^2'
set xlabel 'L [km]' offset -1,0
set multiplot
plot \
'dchi2min_nh.dat' u 1:2 t 'NH'  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih.dat' u 1:2 t 'IH'  w l lt 2 lc rgb 'blue' lw 3
set nomultiplot

reset
