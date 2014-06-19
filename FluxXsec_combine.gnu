set terminal postscript eps enhanced "Times-Roman" color 17
#set logscale x
set logscale y
#set format x "%L"
set format y "10^{%L}"
#set xtics (0.0010.01,0.1,1,10,1.0E2,1.0E3,1.0E4,1.0E5,1.0E6,1.0E7,1.0E8,1.0E9,1.0E10,1.0E11,1E12,1E13,1E14,1E15,1E16)
#set ytics (1,10,1E2,1E3,1E4,1E5,1E6,1E7,1E8,1E9,1E10)
#set tics scale 2
set grid
#set key at 1.0E3,1.0E7 samplen 2
#set key spacing 1.5
set xrange [1.81:8]
set yrange [5E-39:2E-36]

set output "plots/FluxXsec_combine.eps"
set title "P_{reactor} = 16.52GW_{th}"
set xlabel 'E_{/Symbol=\156}  [MeV]' offset -1,0
set ylabel 'd(Flux * Xsec) / dE_{/Symbol=\156}  [1/s/MeV]' offset 1,0
set multiplot
plot \
'rslt_test2/data/FluxXsec.dat' u ($1**2+0.8):($2/(2*$1))/30**2 title '30km'  w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_test2/data/FluxXsec.dat' u ($1**2+0.8):($2/(2*$1))/40**2 title '40km'  w l lt 1 lc rgb 'blue' lw 3 ,\
'rslt_test2/data/FluxXsec.dat' u ($1**2+0.8):($2/(2*$1))/50**2 title '50km'  w l lt 1 lc rgb '#006400' lw 3 ,\
'rslt_test2/data/FluxXsec.dat' u ($1**2+0.8):($2/(2*$1))/60**2 title '60km'  w l lt 1 lc rgb 'orange' lw 3
set nomultiplot

reset
