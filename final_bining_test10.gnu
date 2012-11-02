set terminal postscript eps enhanced 'Times-Roman' color 20
#set logscale x
#set logscale y
#set format x '%L'
#set format y '%L'
#set xtics (0.001,0.01)
#set ytics (1,10,1E2)
#set tics scale 2
set grid
#set key samplen 2
#set key spacing 1.5
#set xlabel 'cost' offset -1,0
#set ylabel 'log_{/=10 10} L (Mpc)' offset 1,0
#set xrange [10:100]
set yrange [0:20]

#set lmargin 8
set output 'plots/final_bining.eps'
#set title 'P_{reactor} = 20GW_{th}, V = 5kton (12.00% free proton), 5 years'
#set title '20GW_{th}, 5kton, 5 years, {/Symbol=\144}E_{vis}/E_{vis} = ( a / {/Symbol=\326}E_{vis} + b )%'
set ylabel '{/=25 Events}' offset 1,0
set xlabel '{/=25 E_{/Symbol=\156} [MeV]}' offset -1,0
#set label '1.5%' at 60,15
#set label '3%' at 50,14
#set label '6%' at 50,9
#set yrange [0:210]
set multiplot
plot \
'rslt_test/data/final_bining.dat' u (($1*0.005+sqrt(1.01))**2+0.8):2 notitle  w histeps lt 1 lc rgb 'blue' lw 3 ,\
10 notitle  w l lt 1 lc rgb 'red' lw 3 ,\
13.33 notitle  w l lt 2 lc rgb 'red' lw 3 ,\
6.67 notitle  w l lt 2 lc rgb 'red' lw 3
set nomultiplot

reset
