set terminal postscript eps enhanced "Times-Roman" color 17
#set logscale x
#set logscale y
#set format x "%L"
#set format y "%L"
#set xtics (0.0010.01,0.1,1,10,1.0E2,1.0E3,1.0E4,1.0E5,1.0E6,1.0E7,1.0E8,1.0E9,1.0E10,1.0E11,1E12,1E13,1E14,1E15,1E16)
#set ytics (1,10,1E2,1E3,1E4,1E5,1E6,1E7,1E8,1E9,1E10)
#set tics scale 2
set grid
#set key at 1.0E3,1.0E7 samplen 2
#set key spacing 1.5
#set xrange [-1:1]
#set yrange [1E-5:2E8]

set output "flux.eps"
set title "Neutrino Flux"
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'Flux' offset 1,0
set multiplot
plot \
'flux.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "noosc.eps"
set title "Neutrino Flux"
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'flux * Xsec' offset 1,0
set multiplot
plot \
'noosc.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "xsec.eps"
set title "Neutrino-p Cross Section"
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'dXsec / dEv (cm^2/MeV)' offset 1,0
set multiplot
plot \
'xsec.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "prob.eps"
set title "Oscillation Prob."
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'Prob.' offset 1,0
set multiplot
plot \
'prob.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "events.eps"
set title "Event shape"
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'dN / dEv (arbitrary)' offset 1,0
set multiplot
plot \
'events.dat' u 1:3 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'events.dat' u 1:4 t 'IH' w l lt 1 lc rgb 'blue' lw 3 ,\
'events.dat' u 1:2 t 'No oscillation'  w l lt 2 lc rgb 'orange' lw 3
set nomultiplot

set output "flux_loe.eps"
set title "Neutrino Flux"
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'Flux' offset 1,0
set multiplot
plot \
'flux_loe.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "noosc_loe.eps"
set title "Neutrino Flux"
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'Flux * Xsec' offset 1,0
set multiplot
plot \
'noosc_loe.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "xsec_loe.eps"
set title "Neutrino-p Cross Section"
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'dXsec / d(L/Ev) (cm^2 MeV/km)' offset 1,0
set multiplot
plot \
'xsec_loe.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "prob_loe.eps"
set title "Oscillation Prob."
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'Prob.' offset 1,0
set multiplot
plot \
'prob_loe.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "events_loe.eps"
set title "Event shape"
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'dN / dEv (arbitrary)' offset 1,0
set multiplot
plot \
'events_loe.dat' u 1:3 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'events_loe.dat' u 1:4 t 'IH' w l lt 1 lc rgb 'blue' lw 3 ,\
'events_loe.dat' u 1:2 t 'No oscillation'  w l lt 2 lc rgb 'orange' lw 3
set nomultiplot

reset
