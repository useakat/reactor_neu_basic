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
set xrange [10:100]
#set yrange [1E-5:2E8]

set output 'plots/dchi2.eps'
set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, No Smearing'
set ylabel '{/Symbol=\104}{/Symbol=\143}^2'
set xlabel 'L [km]' offset -1,0
#set label '1.5%' at 60,15
#set label '3%' at 50,14
#set label '6%' at 50,9
set multiplot
plot \
'dchi2min_nh_0.75_-1.dat' u 1:2 t '0.75%: NH'  w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_-1.dat' u 1:2 t 'IH'  w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_-1.dat' u 1:2 t '1.5%: NH'  w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_-1.dat' u 1:2 t 'IH'  w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_-1.dat' u 1:2 t '3%: NH'  w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_-1.dat' u 1:2 t 'IH'  w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_-1.dat' u 1:2 t '6%: NH'  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_-1.dat' u 1:2 t 'IH'  w l lt 2 lc rgb 'red' lw 3
set nomultiplot

# set output 'plots/params.eps'
# unset title
# set title 'P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years'
# set key samplen 2
# #set xlabel 'L [km]' offset -1,0
# #set label '1.5%' at 60,15
# #set label '3%' at 50,14
# #set label '6%' at 50,9
# set size 1,1.2
# set multiplot layout 5,1 scale 1,1 offset 0,0.1
# set lmargin 8
# set rmargin 2
# set tmargin 0
# set bmargin 0
# unset xlabel
# #unset ylabel
# set format x ""
# set ylabel 'pull factor' offset 1.2,0
# set label 'sin^22{/Symbol=\161}_{12}' at 12,0.365
# set ytics (0.3,0.32,0.34,0.36,0.38)
# set yrange[0.28:0.4]
# plot 'dchi2min_nh_1.5.dat' u 1:7 t '1.5%: NH'  w l lt 1 lc rgb 'purple' lw 3 ,\
# 'dchi2min_ih_1.5.dat' u 1:7 t 'IH'  w l lt 2 lc rgb 'purple' lw 3 ,\
# 'dchi2min_nh_3.dat' u 1:7 t '3%: NH'  w l lt 1 lc rgb 'blue' lw 3 ,\
# 'dchi2min_ih_3.dat' u 1:7 t 'IH'  w l lt 2 lc rgb 'blue' lw 3 ,\
# 'dchi2min_nh_6.dat' u 1:7 t '6%: NH'  w l lt 1 lc rgb 'red' lw 3 ,\
# 'dchi2min_ih_6.dat' u 1:7 t 'IH'  w l lt 2 lc rgb 'red' lw 3

# unset title
# unset label
# set yrange[-0.2:0.02]
# set ytics (-0.15,-0.1,-0.05,0)
# set label 'sin^22{/Symbol=\161}_{13}' at 12,-0.07
# plot 'dchi2min_nh_1.5.dat' u 1:11 notitle  w l lt 1 lc rgb 'purple' lw 3 ,\
# 'dchi2min_ih_1.5.dat' u 1:11 notitle  w l lt 2 lc rgb 'purple' lw 3 ,\
# 'dchi2min_nh_3.dat' u 1:11 notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
# 'dchi2min_ih_3.dat' u 1:11 notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
# 'dchi2min_nh_6.dat' u 1:11 notitle  w l lt 1 lc rgb 'red' lw 3 ,\
# 'dchi2min_ih_6.dat' u 1:11 notitle  w l lt 2 lc rgb 'red' lw 3

# unset label
# set ylabel 'pull factor' offset 2.2,0
# set yrange[-0.1:0.025]
# set ytics (-0.025,-0.05,-0.075,0)
# set label '{/Symbol=\104}m^2_{12}' at 12,-0.03
# plot 'dchi2min_nh_1.5.dat' u 1:15 notitle w l lt 1 lc rgb 'purple' lw 3 ,\
# 'dchi2min_ih_1.5.dat' u 1:15 notitle  w l lt 2 lc rgb 'purple' lw 3 ,\
# 'dchi2min_nh_3.dat' u 1:15 notitle w l lt 1 lc rgb 'blue' lw 3 ,\
# 'dchi2min_ih_3.dat' u 1:15 notitle w l lt 2 lc rgb 'blue' lw 3 ,\
# 'dchi2min_nh_6.dat' u 1:15 notitle w l lt 1 lc rgb 'red' lw 3 ,\
# 'dchi2min_ih_6.dat' u 1:15 notitle w l lt 2 lc rgb 'red' lw 3

# unset label
# set ylabel 'pull factor' offset 1.2,0
# set yrange[-0.1:1.1]
# set ytics (0,0.25,0.5,0.75,1)
# set label '{/Symbol=\174}{/Symbol=\104}m^2_{13}{/Symbol=\174}' at 12,0.7
# plot 'dchi2min_nh_1.5.dat' u 1:19 notitle w l lt 1 lc rgb 'purple' lw 3 ,\
# 'dchi2min_ih_1.5.dat' u 1:19 notitle  w l lt 2 lc rgb 'purple' lw 3 ,\
# 'dchi2min_nh_3.dat' u 1:19 notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
# 'dchi2min_ih_3.dat' u 1:19 notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
# 'dchi2min_nh_6.dat' u 1:19 notitle  w l lt 1 lc rgb 'red' lw 3 ,\
# 'dchi2min_ih_6.dat' u 1:19 notitle  w l lt 2 lc rgb 'red' lw 3

# set xlabel 'L [km]' offset 0,0.4
# set format x
# unset label
# #set ylabel 'pull factor' offset 1.5,0
# set yrange[-0.18:0.02]
# set ytics (-0.15,-0.1,-0.05,0)
# set label 'Norm' at 12,-0.03 
# plot 'dchi2min_nh_1.5.dat' u 1:23 notitle  w l lt 1 lc rgb 'purple' lw 3 ,\
# 'dchi2min_ih_1.5.dat' u 1:23 notitle w l lt 2 lc rgb 'purple' lw 3 ,\
# 'dchi2min_nh_3.dat' u 1:23 notitle w l lt 1 lc rgb 'blue' lw 3 ,\
# 'dchi2min_ih_3.dat' u 1:23 notitle w l lt 2 lc rgb 'blue' lw 3 ,\
# 'dchi2min_nh_6.dat' u 1:23 notitle w l lt 1 lc rgb 'red' lw 3 ,\
# 'dchi2min_ih_6.dat' u 1:23 notitle w l lt 2 lc rgb 'red' lw 3

# set nomultiplot

reset
set grid
set key samplen 2 at 99,0.97
set output 'plots/params2.eps'
unset title
set title '{/=20 P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years}, No Smearing'
#set xlabel 'L [km]' offset -1,0
#set label '1.5%' at 60,15
#set label '3%' at 50,14
#set label '6%' at 50,9
set size 1,1.23
set xrange[10:100]
set multiplot layout 5,1 scale 1,1 offset 0,0.12
set lmargin 8
set rmargin 3
set tmargin 0
set bmargin 0
unset xlabel
#unset ylabel
set format x ""
#set ylabel '{/=25 pull factor}' offset 1,0
set label '{/=25 sin^22{/Symbol=\161}_{12}}' at 12,0.68
set ytics (0,0.25,0.5,0.75)
set yrange[-0.25:1]
plot \
'dchi2min_nh_0.75_-1.dat' u 1:7 t '0.75%: NH'  w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_-1.dat' u 1:7 t 'IH'  w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_-1.dat' u 1:7 t '1.5%: NH'  w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_-1.dat' u 1:7 t 'IH'  w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_-1.dat' u 1:7 t '3%: NH'  w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_-1.dat' u 1:7 t 'IH'  w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_-1.dat' u 1:7 t '6%: NH'  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_-1.dat' u 1:7 t 'IH'  w l lt 2 lc rgb 'red' lw 3

unset title
unset label
set yrange[-0.5:0.75]
set ytics (-0.25,-0,0.25,0.5)
set label '{/=25 sin^22{/Symbol=\161}_{13}}' at 12,0.4
plot \
'dchi2min_nh_0.75_-1.dat' u 1:11 notitle  w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_-1.dat' u 1:11 notitle  w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_-1.dat' u 1:11 notitle  w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_-1.dat' u 1:11 notitle  w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_-1.dat' u 1:11 notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_-1.dat' u 1:11 notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_-1.dat' u 1:11 notitle  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_-1.dat' u 1:11 notitle  w l lt 2 lc rgb 'red' lw 3

unset label
set ylabel '{/=25 pull factor}' offset 1.5,0
set yrange[-0.5:0.75]
set ytics (-0.25,-0,0.25,0.5)
set label '{/=25 {/Symbol=\104}m^2_{12}}' at 12,0.48
plot \
'dchi2min_nh_0.75_-1.dat' u 1:15 notitle w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_-1.dat' u 1:15 notitle w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_-1.dat' u 1:15 notitle w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_-1.dat' u 1:15 notitle w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_-1.dat' u 1:15 notitle w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_-1.dat' u 1:15 notitle w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_-1.dat' u 1:15 notitle w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_-1.dat' u 1:15 notitle w l lt 2 lc rgb 'red' lw 3

unset label
unset ylabel
set yrange[-0.25:1]
set ytics (0,0.25,0.5,0.75)
set label '{/=25 {/Symbol=\174}{/Symbol=\104}m^2_{13}{/Symbol=\174}}' at 12,0.68
plot \
'dchi2min_nh_0.75_-1.dat' u 1:19 notitle w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_-1.dat' u 1:19 notitle w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_-1.dat' u 1:19 notitle w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_-1.dat' u 1:19 notitle w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_-1.dat' u 1:19 notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_-1.dat' u 1:19 notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_-1.dat' u 1:19 notitle  w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_-1.dat' u 1:19 notitle  w l lt 2 lc rgb 'red' lw 3

set xlabel '{/=25 L [km]}' offset 0,0
set format x
unset label
#set ylabel 'pull factor' offset 1.5,0
set yrange[-0.5:0.75]
set ytics (-0.25,-0,0.25,0.5)
set label '{/=25 Norm}' at 12,0.48 
plot \
'dchi2min_nh_0.75_-1.dat' u 1:23 notitle w l lt 1 lc rgb 'orange' lw 3 ,\
'dchi2min_ih_0.75_-1.dat' u 1:23 notitle w l lt 2 lc rgb 'orange' lw 3 ,\
'dchi2min_nh_1.5_-1.dat' u 1:23 notitle w l lt 1 lc rgb '#006400' lw 3 ,\
'dchi2min_ih_1.5_-1.dat' u 1:23 notitle w l lt 2 lc rgb '#006400' lw 3 ,\
'dchi2min_nh_3_-1.dat' u 1:23 notitle w l lt 1 lc rgb 'blue' lw 3 ,\
'dchi2min_ih_3_-1.dat' u 1:23 notitle w l lt 2 lc rgb 'blue' lw 3 ,\
'dchi2min_nh_6_-1.dat' u 1:23 notitle w l lt 1 lc rgb 'red' lw 3 ,\
'dchi2min_ih_6_-1.dat' u 1:23 notitle w l lt 2 lc rgb 'red' lw 3

set nomultiplot


reset
