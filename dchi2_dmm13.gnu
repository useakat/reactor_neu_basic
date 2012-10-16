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
set xrange [0.00227371:0.00236629]
#set yrange [1E-5:2E8]

set output 'dchi2_dmm13.eps'
set title 'P_{reactor} = 20GW_{th}, V = 5kton (12% free proton), 5 years, {/Symbol=\144}E_{vis}/E_{vis} = 2%/{/Symbol=\326}E_{vis}'
set ylabel '{/Symbol=\104}{/Symbol=\143}^2'
set xlabel 'dmm13' offset -1,0
#set label '{/= 25 Binned {/Symbol=\104}{/Symbol=\143}^2}' at 15,35
set label '{/= 25 L = 50 km}
set multiplot
plot \
'data/dchi2_dmm13.dat' u 1:2 t 'NH'  w l lt 1 lc rgb 'red' lw 3
set nomultiplot
