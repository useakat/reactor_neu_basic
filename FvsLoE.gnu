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
#set yrange [0:1E-33]

set output "plots/FluxXsecPee_loe_100.eps"
set title "P_{reactor} = 16.52GW_{th}, L = 100km"
set xlabel 'L/E_{/Symbol=\156} [km/MeV]' offset -1,0
set ylabel 'd( flux * Xsec * Pee) / d(L/E_{/Symbol=\156}) [MeV/s/cm^3]' offset 1,0
set multiplot
plot \
'rslt_test2/data/FluxXsec_loe_100.dat' u 1:2 t 'No Oscillation' w l lt 2 lc rgb 'red' lw 3 ,\
'rslt_test2/data/FluxXsecPeeNH_loe_100.dat' u 1:2 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_test2/data/FluxXsecPeeIH_loe_100.dat' u 1:2 t 'IH' w l lt 1 lc rgb 'blue' lw 3
set nomultiplot

set output "plots/Pee_loe_100.eps"
set title "L = 100km"
set xlabel 'L/E_{/Symbol=\156} [km/MeV]' offset -1,0
set ylabel 'Pee' offset 1,0
set multiplot
plot \
'rslt_test2/data/PeeNH_loe_100.dat' u 1:2 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_test2/data/PeeIH_loe_100.dat' u 1:2 t 'IH' w l lt 1 lc rgb 'blue' lw 3
set nomultiplot

reset
