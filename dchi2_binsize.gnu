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
#set yrange [1E-5:2E8]

#set lmargin 8
set output 'plots/dchi2_binsize.eps'
#set title 'PPPGW_{th}, VVVkton, YYY years, {/Symbol=\144}E_{vis}/E_{vis} = ( a / {/Symbol=\326}E_{vis} + b )%'
set ylabel '{/=25 {/Symbol=\104}{/Symbol=\143}^2_{min}}' offset 1,0
set xlabel '{/=25 bin size [(MeV)^{0.5}]}' offset -1,0

set multiplot
plot \
'rslt_binsize/data/dchi2_binsize_nh_2_0.dat' u 1:2 t 'NH (2, 0)' w l lt 1 lc rgb 'purple' lw 3 ,\
'rslt_binsize/data/dchi2_binsize_nh_3_0.dat' u 1:2 t '(3, 0)' w l lt 1 lc rgb 'orange' lw 3 ,\
'rslt_binsize/data/dchi2_binsize_nh_4_0.dat' u 1:2 t '(4, 0)' w l lt 1 lc rgb 'green' lw 3 ,\
'rslt_binsize/data/dchi2_binsize_nh_5_0.dat' u 1:2 t '(5, 0)' w l lt 1 lc rgb 'blue' lw 3 ,\
'rslt_binsize/data/dchi2_binsize_nh_6_0.dat' u 1:2 t '(6, 0)' w l lt 1 lc rgb 'red' lw 3
set nomultiplot

reset