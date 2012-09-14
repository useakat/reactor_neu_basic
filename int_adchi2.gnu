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

set output "plots/int_adchi2.eps"
set title "P_{reactor} = 20GW_{th}, V = 5kton (12.00% free proton), 5 years,  {/Symbol=\144}E_{vis}/E_{vis} = 6%/{/Symbol=\326}E_{vis}"
set xlabel 'E_{/Symbol=\156} [MeV]' offset -1,0
set ylabel '{/Symbol=\104}{/Symbol=\143}^2' offset 0,0
set label '{/= 25 Analytic {/Symbol=\104}{/Symbol=\143}^2}' at 15,35
#set logscale y
#set logscale x
#set format y "10^%L"
#set xrange [1.81:8]
#set key at 1.5,5E5 samplen 2
#set xtics (2,3,4,5,6,7,8)    
#set nogrid    

set multiplot
plot \
'int_adchi2_fit2nh_6.dat' u 1:2 title 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'int_adchi2_fit2ih_6.dat' u 1:2 title 'IH' w l lt 1 lc rgb 'blue' lw 3 
set nomultiplot

reset
