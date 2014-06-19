set terminal postscript eps enhanced "Times-Roman" color 17
#set logscale x
#set logscale y
#set format x "%L"
#set format y "%L"
#set xtics (0.0010.01,0.1,1,10,1.0E2,1.0E3,1.0E4,1.0E5)
#set ytics (1,10,1E2,1E3,1E4,1E5,1E6,1E7,1E8,1E9,1E10)
#set tics scale 2
set grid
#set key at 1.0E3,1.0E7 samplen 2
#set key spacing 1.5
#set xrange [-1:1]
#set yrange [1E-5:2E8]

set output "plots/N.eps"
set title "P_{reactor} = 16.52GW_{th}, V = 10kton (12.00% free proton), 5 years, {/Symbol=\144}E_{vis}/E_{vis} = 3%/{/Symbol=\326}E_{vis}"
set xlabel 'E_{/Symbol=\156} [MeV]' offset -1,0
set ylabel 'dN / dE_{/Symbol=\156} [1/MeV]' offset 0,0
set logscale y
set logscale x
set format y "10^%L"
set xrange [1.81:8]
#set yrange [1:1E6]
#set key at 1.5,5E5 samplen 2
set xtics (2,3,4,5,6,7,8)    

set multiplot
plot \
'rslt_test4/data/N_nh_10.dat' u 1:2 t '10km' w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_test4/data/N_nh_20.dat' u 1:2 t '20km' w l lt 1 lc rgb 'green' lw 3 ,\
'rslt_test4/data/N_nh_30.dat' u 1:2 t '30km' w l lt 1 lc rgb 'blue' lw 3 ,\
'rslt_test4/data/N_nh_40.dat' u 1:2 t '40km' w l lt 1 lc rgb 'purple' lw 3 ,\
'rslt_test4/data/N_nh_50.dat' u 1:2 t '50km' w l lt 1 lc rgb 'cyan' lw 3 ,\
'rslt_test4/data/N_nh_60.dat' u 1:2 t '60km' w l lt 1 lc rgb 'black' lw 3 ,\
'rslt_test4/data/N_nh_70.dat' u 1:2 t '70km' w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_test4/data/N_nh_80.dat' u 1:2 t '80km' w l lt 1 lc rgb 'gray' lw 3 ,\
'rslt_test4/data/N_nh_90.dat' u 1:2 t '90km' w l lt 1 lc rgb 'orange' lw 3 ,\
'rslt_test4/data/N_nh_100.dat' u 1:2 t '100km' w l lt 1 lc rgb 'green' lw 3 ,\
'rslt_test4/data/N_ih_10.dat' u 1:2 notitle w l lt 2 lc rgb 'red' lw 3 ,\
'rslt_test4/data/N_ih_20.dat' u 1:2 notitle w l lt 2 lc rgb 'green' lw 3 ,\
'rslt_test4/data/N_ih_30.dat' u 1:2 notitle w l lt 2 lc rgb 'blue' lw 3 ,\
'rslt_test4/data/N_ih_40.dat' u 1:2 notitle w l lt 2 lc rgb 'purple' lw 3 ,\
'rslt_test4/data/N_ih_50.dat' u 1:2 notitle w l lt 2 lc rgb 'cyan' lw 3 ,\
'rslt_test4/data/N_ih_60.dat' u 1:2 notitle w l lt 2 lc rgb 'black' lw 3 ,\
'rslt_test4/data/N_ih_70.dat' u 1:2 notitle w l lt 2 lc rgb 'red' lw 3 ,\
'rslt_test4/data/N_ih_80.dat' u 1:2 notitle w l lt 2 lc rgb 'gray' lw 3 ,\
'rslt_test4/data/N_ih_90.dat' u 1:2 notitle w l lt 2 lc rgb 'orange' lw 3 ,\
'rslt_test4/data/N_ih_100.dat' u 1:2 notitle w l lt 2 lc rgb 'green' lw 3
set nomultiplot

reset
