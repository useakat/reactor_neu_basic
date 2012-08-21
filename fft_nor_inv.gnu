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

set output 'plots/fct_nor_inv_1_300.eps'
set xlabel '300 km   dE/E = 1 %' offset -1,0
set multiplot
plot \
'fct_nor.dat' u 1:2 t 'FCT: NH'  w l lt 1 lc rgb 'red' lw 3 ,\
'fct_nor.dat' u 1:3 t 'err +'  w l lt 2 lc rgb 'red' lw 1 ,\
'fct_nor.dat' u 1:4 t 'err -'  w l lt 3 lc rgb 'red' lw 1 ,\
'fct_inv.dat' u 1:2 t 'IH'  w l lt 1 lc rgb 'blue' lw 3 ,\
'fct_inv.dat' u 1:3 t 'err +'  w l lt 2 lc rgb 'blue' lw 1 ,\
'fct_inv.dat' u 1:4 t 'err -'  w l lt 3 lc rgb 'blue' lw 1
set nomultiplot
set xlabel '300 km   dE/E = 1 %' offset -1,0
set output 'plots/fst_nor_inv_1_300.eps'
plot \
'fst_nor.dat' u 1:2 t 'FST: NH'  w l lt 1 lc rgb 'red' lw 3 ,\
'fst_nor.dat' u 1:3 t 'err +'  w l lt 2 lc rgb 'red' lw 1 ,\
'fst_nor.dat' u 1:4 t 'err -'  w l lt 3 lc rgb 'red' lw 1 ,\
'fst_inv.dat' u 1:2 t 'IH'  w l lt 1 lc rgb 'blue' lw 3 ,\
'fst_inv.dat' u 1:3 t 'err +'  w l lt 2 lc rgb 'blue' lw 1 ,\
'fst_inv.dat' u 1:4 t 'err -'  w l lt 3 lc rgb 'blue' lw 1
set nomultiplot
reset
