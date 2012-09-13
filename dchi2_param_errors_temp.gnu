set terminal postscript eps enhanced 'Times-Roman' color 17
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
set xrange [1:100]
#set yrange [1E-5:2E8]

set grid
set key samplen 2 at 99,0.97
set output 'plots/param_errors.eps'
unset title
set title '{/=20 P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years}, No Smearing'
#set xlabel 'L [km]' offset -1,0
#set label '1.5%' at 60,15
#set label '3%' at 50,14
#set label '6%' at 50,9
set size 1,1.07
set multiplot layout 5,1 scale 1,1 offset 0,-0.05
set lmargin 8
set rmargin 3
set tmargin 0
set bmargin 0
unset xlabel
#unset ylabel
set format x ""
#set ylabel '{/=25 Error_{fit}/Error}' offset 1,0
set label '{/=25 sin^22{/Symbol=\161}_{12}}' at 12,0.4
set label '{/=20 {/Symbol=\163}_{input} = 0.024}' at 30,0.7
set ytics (0.2,0.4,0.6,0.8)
set yrange[0:1]
plot \
'dchi2min_nh_0.75_1.dat' u 1:($5/$6) t '0.75%: NH'  w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_1.dat' u 1:($5/$6) t 'IH'  w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_1.dat' u 1:($5/$6) t '1.5%: NH'  w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_1.dat' u 1:($5/$6) t 'IH'  w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_1.dat' u 1:($5/$6) t '3%: NH'  w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_1.dat' u 1:($5/$6) t 'IH'  w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_1.dat' u 1:($5/$6) t '6%: NH'  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_1.dat' u 1:($5/$6) t 'IH'  w l lt 2 lc rgb 'red' lw 3

unset title
unset label
#set yrange[-0.2:0.02]
#set ytics (-0.15,-0.1,-0.05,0)
set label '{/=25 sin^22{/Symbol=\161}_{13}}' at 12,0.35
set label '{/=20 {/Symbol=\163}_{input} = 0.005}' at 30,0.65
plot \
'dchi2min_nh_0.75_1.dat' u 1:($9/$10) notitle  w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_1.dat' u 1:($9/$10) notitle  w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_1.dat' u 1:($9/$10) notitle  w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_1.dat' u 1:($9/$10) notitle  w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_1.dat' u 1:($9/$10) notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_1.dat' u 1:($9/$10) notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_1.dat' u 1:($9/$10) notitle  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_1.dat' u 1:($9/$10) notitle  w l lt 2 lc rgb 'red' lw 3

unset label
set ylabel '{/=25 {/Symbol=\163}_{fit} / {/Symbol=\163}_{input}}' offset 1,0
#set yrange[-0.1:0.025]
#set ytics (-0.025,-0.05,-0.075,0)
set label '{/=25 {/Symbol=\104}m^2_{12}}' at 12,0.35
set label '{/=20 {/Symbol=\163}_{input} = 0.2{/Symbol=\264}10^{-5}}' at 30,0.7
plot \
'dchi2min_nh_0.75_1.dat' u 1:($13/$14) notitle w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_1.dat' u 1:($13/$14) notitle w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_1.dat' u 1:($13/$14) notitle w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_1.dat' u 1:($13/$14) notitle w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_1.dat' u 1:($13/$14) notitle w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_1.dat' u 1:($13/$14) notitle w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_1.dat' u 1:($13/$14) notitle w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_1.dat' u 1:($13/$14) notitle w l lt 2 lc rgb 'red' lw 3

unset label
unset ylabel
set xlabel '{/=25 L [km]}' offset 0,0
set format x
set yrange[0:1]
set ytics (0,0.2,0.4,0.6,0.8)
set label '{/=25 {/Symbol=\174}{/Symbol=\104}m^2_{13}{/Symbol=\174}}' at 12,0.4
set label '{/=20 {/Symbol=\163}_{input} = 0.1{/Symbol=\264}10^{-3}}' at 30,0.7
plot \
'dchi2min_nh_0.75_1.dat' u 1:($17/$18) notitle w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_1.dat' u 1:($17/$18) notitle w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_1.dat' u 1:($17/$18) notitle w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_1.dat' u 1:($17/$18) notitle w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_1.dat' u 1:($17/$18) notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_1.dat' u 1:($17/$18) notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_1.dat' u 1:($17/$18) notitle  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_1.dat' u 1:($17/$18) notitle  w l lt 2 lc rgb 'red' lw 3

set nomultiplot


reset
