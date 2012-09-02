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

set output 'plots/FluxXsec_h.eps'
set title 'P_{reactor} = 20GW_{th}, L = 1km, Simpson[ acc=1%, ndiv=2^2 ]'    
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'd( Flux * Xsec ) / dEv [1/s/MeV^2]' offset 2,0
set multiplot
plot \
'event_dat1_6.dat' u ($1**2+0.8):2 t 'dE_{vis}/E_{vis} = 6%/Sqrt(E_{vis})' with histeps lt 1 lc rgb 'red' lw 3 ,\
'event_dat2_6.dat' u ($1**2+0.8):2 t 'Center Value' with points lt 2 lc rgb 'blue' lw 3
set nomultiplot

reset
