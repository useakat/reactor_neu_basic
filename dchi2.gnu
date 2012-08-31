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

set output 'plots/dchi2.eps'
set xlabel 'L (km)' offset -1,0
set multiplot
plot \
'dchi2min_nh.dat' u 1:2 t 'Delta Chi2 (NH)'  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih.dat' u 1:2 t 'Delta Chi2 (IH)'  w l lt 2 lc rgb 'blue' lw 3
set nomultiplot

set output 'plots/noosc.eps'
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'Flux * Xsec [1/s/MeV]' offset 0,0
set multiplot
plot \
'event_dat.dat' u ($1**2+0.8):2 t 'Flux * Xsec (NH)' with histeps lt 1 lc rgb 'red' lw 3
set nomultiplot

reset
