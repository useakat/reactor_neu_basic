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
set xrange [10:100]
#set yrange [1E-5:2E8]

set output 'plots/dchi2_ERES.eps'
set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, {/Symbol=\144}E_{vis}/E_{vis} = ERES%/{/Symbol=\326}E_{vis}'
set ylabel '{/Symbol=\104}{/Symbol=\143}^2'
set xlabel 'L [km]' offset -1,0
set label '{/= 25 Binned {/Symbol=\104}{/Symbol=\143}^2}' at 15,35
set label '{/= 25 D = 0.0003' at 15,30
set multiplot
plot \
'dchi2min_nh.dat' u 1:2 t 'NH'  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih.dat' u 1:2 t 'IH'  w l lt 1 lc rgb 'blue' lw 3
set nomultiplot

set output 'plots/sin212_2_ERES.eps'
set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, {/Symbol=\144}E_{vis}/E_{vis} = ERES%/{/Symbol=\326}E_{vis}'
set ylabel 'sin^22{/Symbol=\161}_{12}'
set xlabel 'L [km]' offset -1,0
set multiplot
plot \
'dchi2min_nh.dat' u 1:4 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih.dat' u 1:4 t 'IH' w l lt 1 lc rgb 'blue' lw 3 ,\
0.85 t 'Central Value' lt 1 lc rgb 'green' lw 3 ,\
0.875 notitle lt 2 lc rgb 'green' lw 3 ,\
0.825 notitle lt 2 lc rgb 'green' lw 3
set nomultiplot

set output 'plots/sin213_2_ERES.eps'
set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, {/Symbol=\144}E_{vis}/E_{vis} = ERES%/{/Symbol=\326}E_{vis}'
set ylabel 'sin^22{/Symbol=\161}_{13}'
set xlabel 'L [km]' offset -1,0
set multiplot
plot \
'dchi2min_nh.dat' u 1:7 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih.dat' u 1:7 t 'IH' w l lt 1 lc rgb 'blue' lw 3 ,\
0.092 t 'Central Value' lt 1 lc rgb 'green' lw 3 ,\
0.109 notitle lt 2 lc rgb 'green' lw 3 ,\
0.075 notitle lt 2 lc rgb 'green' lw 3
set nomultiplot

set output 'plots/dm21_2_ERES.eps'
set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, {/Symbol=\144}E_{vis}/E_{vis} = ERES%/{/Symbol=\326}E_{vis}'
set ylabel '{/Symbol=\104}m^2_{21}'
set xlabel 'L [km]' offset -1,0
set multiplot
plot \
'dchi2min_nh.dat' u 1:10 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih.dat' u 1:10 t 'IH' w l lt 1 lc rgb 'blue' lw 3 ,\
7.5E-5 t 'Central Value' lt 1 lc rgb 'green' lw 3 ,\
7.7E-5 notitle lt 2 lc rgb 'green' lw 3 ,\
7.3E-5 notitle lt 2 lc rgb 'green' lw 3
set nomultiplot

set output 'plots/dm31_2_ERES.eps'
set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, {/Symbol=\144}E_{vis}/E_{vis} = ERES%/{/Symbol=\326}E_{vis}'
set ylabel '{/Symbol=\104}m^2_{31}'
set xlabel 'L [km]' offset -1,0
set multiplot
plot \
'dchi2min_nh.dat' u 1:13 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih.dat' u 1:13 t 'IH' w l lt 1 lc rgb 'blue' lw 3 ,\
2.35E-3 t 'Central Value' lt 1 lc rgb 'green' lw 3 ,\
2.65E-3 notitle lt 2 lc rgb 'green' lw 3 ,\
2.05E-3 notitle lt 2 lc rgb 'green' lw 3
set nomultiplot

set output 'plots/ovnorm_ERES.eps'
set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, {/Symbol=\144}E_{vis}/E_{vis} = ERES%/{/Symbol=\326}E_{vis}'
set ylabel 'Normalization Factor'
set xlabel 'L [km]' offset -1,0
set multiplot
plot \
'dchi2min_nh.dat' u 1:16 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih.dat' u 1:16 t 'IH' w l lt 1 lc rgb 'blue' lw 3 ,\
1 t 'Central Value' lt 1 lc rgb 'green' lw 3 ,\
1.03 notitle lt 2 lc rgb 'green' lw 3 ,\
0.97 notitle lt 2 lc rgb 'green' lw 3
set nomultiplot

reset
