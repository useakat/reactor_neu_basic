set terminal postscript eps enhanced "Times-Roman" color 17
set grid
#set key at 1.0E3,1.0E7 samplen 2
#set key spacing 1.5
#set tics scale 2
set logscale x
#set format x "%L"
set xrange [1.81:8]
set xtics (2,3,4,5,6,7,8)    
#set logscale y
#set format y "%L"
#set ytics (1,10,1E2,1E3,1E4,1E5,1E6,1E7,1E8,1E9,1E10)

set output "plots/EventDistmin_fit2nh_combine.eps"
#set title "PPPGW_{th}, VVVkton, YYY years, LLL km"

set size 1,1

set multiplot layout 2,2 scale 1,0.9 offset 0,0.1
set lmargin 9
set rmargin 0
set tmargin 3
set bmargin 0

unset xlabel
set format x ""
unset ylabel
set yrange [0:5E4]
plot \
'DATADIR/events_nh_30_0.dat' u ($1**2+0.8):($2/(2*$1)) t 'NH' w l lt 2 lc rgb 'blue' lw 3 ,\
'DATADIR/events_ih_30_0.dat' u ($1**2+0.8):($2/(2*$1)) t 'IH' w l lt 2 lc rgb 'red' lw 3 ,\
'DATADIR/events_nhmin_30_0.dat' u ($1**2+0.8):($2/(2*$1)) t 'Best Fit to NH data' w l lt 1 lc rgb 'red' lw 1

set lmargin 0
set format y ""
plot \
'DATADIR/events_nh_30_6.dat' u ($1**2+0.8):($2/(2*$1)) t 'NH' w l lt 2 lc rgb 'blue' lw 3 ,\
'DATADIR/events_ih_30_6.dat' u ($1**2+0.8):($2/(2*$1)) t 'IH' w l lt 2 lc rgb 'red' lw 3 ,\
'DATADIR/events_nhmin_30_6.dat' u ($1**2+0.8):($2/(2*$1)) t 'Best Fit to NH data' w l lt 1 lc rgb 'red' lw 1

set lmargin 9
set ylabel 'dN / dE_{/Symbol=\156} [1/MeV]' offset 0,0
set yrange [0:1E4]
set format y
plot \
'DATADIR/events_nh_50_0.dat' u ($1**2+0.8):($2/(2*$1)) t 'NH' w l lt 2 lc rgb 'blue' lw 3 ,\
'DATADIR/events_ih_50_0.dat' u ($1**2+0.8):($2/(2*$1)) t 'IH' w l lt 2 lc rgb 'red' lw 3 ,\
'DATADIR/events_nhmin_50_0.dat' u ($1**2+0.8):($2/(2*$1)) t 'Best Fit to NH data' w l lt 1 lc rgb 'red' lw 1

set lmargin 0
unset ylabel
set format y ""
set xlabel 'E_{/Symbol=\156} [MeV]' offset -1,0
set format x
plot \
'DATADIR/events_nh_50_6.dat' u ($1**2+0.8):($2/(2*$1)) t 'NH' w l lt 2 lc rgb 'blue' lw 3 ,\
'DATADIR/events_ih_50_6.dat' u ($1**2+0.8):($2/(2*$1)) t 'IH' w l lt 2 lc rgb 'red' lw 3 ,\
'DATADIR/events_nhmin_50_6.dat' u ($1**2+0.8):($2/(2*$1)) t 'Best Fit to NH data' w l lt 1 lc rgb 'red' lw 1

set nomultiplot

reset
