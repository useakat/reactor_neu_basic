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

set output "plots/adchi2_100.eps"
set title "P_{reactor} = 20GW_{th}, V = 5kton (12.00% free proton), 5 years, 100 km"
set xlabel 'E_{/Symbol=\156} [MeV]' offset -1,0
set ylabel 'Del chi2' offset 0,0
#set logscale y
set logscale x
#set format y "10^%L"
set xrange [1.81:8]
#set key at 1.5,5E5 samplen 2
set xtics (2,3,4,5,6,7,8)    

set multiplot
plot \
'adchi2_fit2nh_100_6.dat' u ($1**2+0.8):2 title 'fit to NH' w l lt 1 lc rgb 'red' lw 1 ,\
'adchi2_fit2ih_100_6.dat' u ($1**2+0.8):2 title 'fit to IH' w l lt 1 lc rgb 'blue' lw 1
set nomultiplot

reset
