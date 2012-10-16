set terminal postscript eps enhanced 'Times-Roman' color 17
#set logscale x
#set logscale y
#set format x '%L'
#set format y '10^{%L}'
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
set key samplen 2 horizontal at graph 0.95, graph 0.9
set output 'plots/param_errors.eps'
unset title
#set title '{/=20 P_{reactor} = 20GW_{th}, V = 5kton (12.00% free proton), 5 years}'
#set xlabel 'L [km]' offset -1,0
#set label '1.5%' at 60,15
#set label '3%' at 50,14
#set label '6%' at 50,9
set size 1,0.94
set multiplot layout 5,1 scale 1,1 offset 0,-0.08
set lmargin 9
set rmargin 2
set tmargin 0
set bmargin 0
unset xlabel
#unset ylabel
set format x ""
#set ylabel '{/=25 Error_{fit}/Error}' offset 1,0
set label '{/=25 sin^22{/Symbol=\161}_{12}}' at graph 0.03, graph 0.5
#set label '{/=20 {/Symbol=\163}_{input} = 0.024}' at 30,0.7
set ytics ("0.5"5E-3,1E-2,1.5E-2,2E-2,""2.5E-2)
set yrange[0:3E-2]
set format y '%1.1l'
set label '{/=15 {/Symbol=\264}10^{-2}' at -5, graph 0.9
plot \
'rslt_run0.5err/data/dchi2min_nh_2_0.dat' u 1:5 t '2%: NH'  w l lt 1 lc rgb '#006400' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_2_0.dat' u 1:5 t 'IH'  w l lt 2 lc rgb '#006400' lw 3 ,\
'rslt_run0.5err/data/dchi2min_nh_3_0.dat' u 1:5 t '3%: NH'  w l lt 1 lc rgb 'blue' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_3_0.dat' u 1:5 t 'IH'  w l lt 2 lc rgb 'blue' lw 3 ,\
'rslt_run0.5err/data/dchi2min_nh_6_0.dat' u 1:5 t '6%: NH'  w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_6_0.dat' u 1:5 t 'IH'  w l lt 2 lc rgb 'red' lw 3

unset title
unset label
set yrange[0:6E-3]
set ytics (1E-3,2E-3,3E-3,4E-3,"" 5E-3)
set label '{/=25 sin^22{/Symbol=\161}_{13}}' at graph 0.03, graph 0.75
#set label '{/=20 {/Symbol=\163}_{input} = 0.005}' at 30,0.65
set format y '%1.0l'
set label '{/=15 {/Symbol=\264}10^{-3}' at -5, graph 0.9
plot \
'rslt_run0.5err/data/dchi2min_nh_2_0.dat' u 1:9 notitle  w l lt 1 lc rgb '#006400' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_2_0.dat' u 1:9 notitle  w l lt 2 lc rgb '#006400' lw 3 ,\
'rslt_run0.5err/data/dchi2min_nh_3_0.dat' u 1:9 notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_3_0.dat' u 1:9 notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
'rslt_run0.5err/data/dchi2min_nh_6_0.dat' u 1:9 notitle  w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_6_0.dat' u 1:9 notitle  w l lt 2 lc rgb 'red' lw 3

unset label
set ylabel '{/=25 Statistical Error}' offset -2,3
set yrange[0:2.5E-6]
#set ytics (5E-7,1E-6,1.5E-6,"" 2E-6)
#set ytics (1E-6,1E-5)
set ytics ("0.5" 5E-7,1E-6,1.5E-6,"" 2E-6)
set format y '%1.1l'
set label '{/=25 {/Symbol=\104}m^2_{21}}' at graph 0.05, graph 0.7
#set label '{/=20 {/Symbol=\163}_{input} = 0.2{/Symbol=\264}10^{-5}}' at 
set label '{/=15 {/Symbol=\264}10^{-6}eV^2' at -9, graph 0.9
plot \
'rslt_run0.5err/data/dchi2min_nh_2_0.dat' u 1:13 notitle w l lt 1 lc rgb '#006400' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_2_0.dat' u 1:13 notitle w l lt 2 lc rgb '#006400' lw 3 ,\
'rslt_run0.5err/data/dchi2min_nh_3_0.dat' u 1:13 notitle w l lt 1 lc rgb 'blue' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_3_0.dat' u 1:13 notitle w l lt 2 lc rgb 'blue' lw 3 ,\
'rslt_run0.5err/data/dchi2min_nh_6_0.dat' u 1:13 notitle w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_6_0.dat' u 1:13 notitle w l lt 2 lc rgb 'red' lw 3

unset label
unset ylabel
set xlabel '{/=25 L [km]}' offset 0,0
set format x
set yrange[0:9E-5]
set format y '%1.0l'
#set ytics (0,1E-5,3E-5,5E-5)
#set ytics (1E-6,1E-5,1E-4)
set ytics (0,2E-5,4E-5,6E-5,"" 8E-5)
set label '{/=25 {/Symbol=\174}{/Symbol=\104}m^2_{31}{/Symbol=\174}}' at graph 0.05, graph 0.7
#set label '{/=20 {/Symbol=\163}_{input} = 0.1{/Symbol=\264}10^{-3}}' at 30,0.7
set label '{/=15 {/Symbol=\264}10^{-5}eV^2' at -9, graph 0.9
plot \
'rslt_run0.5err/data/dchi2min_nh_2_0.dat' u 1:17 notitle w l lt 1 lc rgb '#006400' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_2_0.dat' u 1:17 notitle w l lt 2 lc rgb '#006400' lw 3 ,\
'rslt_run0.5err/data/dchi2min_nh_3_0.dat' u 1:17 notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_3_0.dat' u 1:17 notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
'rslt_run0.5err/data/dchi2min_nh_6_0.dat' u 1:17 notitle  w l lt 1 lc rgb 'red' lw 3 ,\
'rslt_run0.5err/data/dchi2min_ih_6_0.dat' u 1:17 notitle  w l lt 2 lc rgb 'red' lw 3

set nomultiplot


reset
