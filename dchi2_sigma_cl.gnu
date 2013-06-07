set terminal postscript eps enhanced 'Times-Roman' color 20
#set logscale x
set logscale y
#set format x '%L'
#set format y '10^{%L}'
set xtics (0, "" 0.1 1, "" 0.2 1, "" 0.3 1, "" 0.4 1, "" 0.5 1, "" 0.6 1, "" 0.7 1, "" 0.8 1, "" 0.9 1,\
    	   1, "" 1.1 1, "" 1.2 1, "" 1.3 1, "" 1.4 1, "" 1.5 1, "" 1.6 1, "" 1.7 1, "" 1.8 1, "" 1.9 1,\
    	   2, "" 2.1 1, "" 2.2 1, "" 2.3 1, "" 2.4 1, "" 2.5 1, "" 2.6 1, "" 2.7 1, "" 2.8 1, "" 2.9 1,\
    	   3, "" 3.1 1, "" 3.2 1, "" 3.3 1, "" 3.4 1, "" 3.5 1, "" 3.6 1, "" 3.7 1, "" 3.8 1, "" 3.9 1,\
    	   4, "" 4.1 1, "" 4.2 1, "" 4.3 1, "" 4.4 1, "" 4.5 1, "" 4.6 1, "" 4.7 1, "" 4.8 1, "" 4.9 1,\
    	   5, "" 5.1 1, "" 5.2 1, "" 5.3 1, "" 5.4 1, "" 5.5 1, "" 5.6 1, "" 5.7 1, "" 5.8 1, "" 5.9 1,\
    	   6, "" 6.1 1, "" 6.2 1, "" 6.3 1, "" 6.4 1, "" 6.5 1, "" 6.6 1, "" 6.7 1, "" 6.8 1, "" 6.9 1,\
    	   7, "" 7.1 1, "" 7.2 1, "" 7.3 1, "" 7.4 1, "" 7.5 1, "" 7.6 1, "" 7.7 1, "" 7.8 1, "" 7.9 1,\
    	   8, "" 8.1 1, "" 8.2 1, "" 8.3 1, "" 8.4 1, "" 8.5 1, "" 8.6 1, "" 8.7 1, "" 8.8 1, "" 8.9 1,\
    	   9, "" 9.1 1, "" 9.2 1, "" 9.3 1, "" 9.4 1, "" 9.5 1, "" 9.6 1, "" 9.7 1, "" 9.8 1, "" 9.9 1,\
    	   10, "" 10.1 1, "" 10.2 1, "" 10.3 1, "" 10.4 1, "" 10.5 1, "" 10.6 1, "" 10.7 1, "" 10.8 1, "" 10.9 1,\
	   11)
set ytics ("1" 1, "" 0.9 1, "" 0.8 1, "" 0.7 1, "" 0.6 1, "" 0.5 1, "" 0.4 1, "" 0.3 1, "" 0.2 1,\
    	   "0.1" 0.1, "" 0.09 1, "" 0.08 1, "" 0.07 1, "" 0.06 1, "" 0.05 1, "" 0.04 1, "" 0.03 1, "" 0.02 1, \
	   "0.01" 0.01, "" 0.009 1, "" 0.008 1, "" 0.007 1, "" 0.006 1, "" 0.005 1, "" 0.004 1, "" 0.003 1, "" 0.002 1, \
	   "10^{-3}" 1E-3, "" 9E-4 1, "" 8E-4 1, "" 7E-4 1, "" 6E-4 1, "" 5E-4 1, "" 4E-4 1, "" 3E-4 1, "" 2E-4 1,\
	   "10^{-4}" 1E-4, "" 9E-5 1, "" 8E-5 1, "" 7E-5 1, "" 6E-5 1, "" 5E-5 1, "" 4E-5 1, "" 3E-5 1, "" 2E-5 1,\
	   "10^{-5}" 1E-5, "" 9E-6 1, "" 8E-6 1, "" 7E-6 1, "" 6E-6 1, "" 5E-6 1, "" 4E-6 1, "" 3E-6 1, "" 2E-6 1,\
	   "10^{-6}" 1E-6, "" 9E-7 1, "" 8E-7 1, "" 7E-7 1, "" 6E-7 1, "" 5E-7 1, "" 4E-7 1, "" 3E-7 1, "" 2E-7 1,\
	   "10^{-7}" 1E-7)
#set tics scale 2
set grid
set key at graph 0.37,0.37
set key spacing 1.2
#set xlabel 'cost' offset -1,0
#set ylabel 'log_{/=10 10} L (Mpc)' offset 1,0
#set xrange [0:12]
#set yrange [1E-7:2]
set mxtics 10
set mytics 10

n=11
set lmargin 8
set bmargin 4
set output 'plots/dchi2_sigma.eps'
#set title 'P_{reactor} = 16.52GW_{th}, V = 10kton (12.00% free proton), 5 years'
#set title '16.52GW_{th}, 10kton (12.00% proton), ({/Symbol=\144}E_{vis}/E_{vis})^2 = (a %/ {/Symbol=\326}E_{vis})^2 + (b %)^2'
set ylabel '{/=25 1 - P}' offset 0,0
#set xlabel '{/=25 {/Symbol=\326}({/Symbol=\104}{/Symbol=\143}^2)_{min}}' offset -1,0
#set xlabel '  ' offset -1,0
set label '1{/Symbol=\163}' at n,0.3173 offset 0.5,0
set label '2{/Symbol=\163}' at n,0.0455 offset 0.5,0
set label '3{/Symbol=\163}' at n,0.0027 offset 0.5,0
set label '4{/Symbol=\163}' at n,0.000063 offset 0.5,0
set label '5{/Symbol=\163}' at n,0.00000057 offset 0.5,0
#set label '6{/Symbol=\163}' at n,0.000000002 offset 0.5,0
#set label '{/Symbol=\264}1/16' at 0.4,1.1 tc rgb 'red'
#set label '{/Symbol=\264}1/4' at 1.3,0.7 tc rgb 'red'
set label '{/Symbol=\264}1' at 3.2,0.16 tc rgb 'red'
set label '{/Symbol=\264}4' at 6.8,0.001 tc rgb 'red'
set label '{/Symbol=\264}9' at 10,0.0000008 tc rgb 'red'
#set label '{/Symbol=\264}1/4' at 0.3,0.2 tc rgb 'blue'
set label '{/Symbol=\264}1' at 1.65,0.15 tc rgb 'blue'
set label '{/Symbol=\264}4' at 3.5,0.025 tc rgb 'blue'
set label '{/Symbol=\264}9' at 5.3,0.0018 tc rgb 'blue'
set label '{/Symbol=\264}16' at 6.7,0.00009 tc rgb 'blue'
set label '{/Symbol=\264}25' at 8.5,0.0000015 tc rgb 'blue'
#set label '{/=18 (2{/Symbol=\163})}' at 4, 4.1E-6
#set label '{/=18 (2{/Symbol=\163})}' at 4, 1.5E-6
set xrange [0:11]
set yrange [1E-7:2]
set pointsize 1
set multiplot
sigma=1
plot \
'rslt_test/data/dchi2_cl_nostat.dat' u (sqrt($1)):(1-$2) t 'No Fluctuation'  w l lt 2 lc rgb 'black' lw 4 ,\
'rslt_test/data/dchi2_cl_analytic_2_0.5.dat' every::0::20 u 1:3 t 'Fluctuation'  w l lt 1 lc rgb '#006400' lw 4 ,\
'rslt_test/data/dchi2_cl_nh_2_0.5.dat' every::0::15 u (sqrt($1)):(1-$3):(1-$3-sigma*$4):(1-$3+sigma*$4) t '(a, b) = (2, 0.5)'  w yerrorbars pointtype 7 lt 1 lc rgb 'red' lw 2 ,\
'rslt_test/data/dchi2_cl_nh_3_0.75.dat' every::0::15 u (sqrt($1)):(1-$3):(1-$3-sigma*$4):(1-$3+sigma*$4) t '         (3, 0.75)'  w yerrorbars pointtype 5 lt 1 lc rgb 'blue' lw 2 ,\
0.3173 notitle w l lt 2 lc rgb 'black' lw 2 ,\
0.0455 notitle w l lt 2 lc rgb 'black' lw 2 ,\
0.0027 notitle w l lt 2 lc rgb 'black' lw 2 ,\
0.000063 notitle w l lt 2 lc rgb 'black' lw 2 ,\
0.00000057 notitle w l lt 2 lc rgb 'black' lw 2 ,\
0.000000002 notitle w l lt 2 lc rgb 'black' lw 2
set nomultiplot

#'rslt_test/data/dchi2_cl_analytic_3_0.75.dat' every::0::20 u 1:2 t 'Fluctuation'  w l lt 2 lc rgb 'red' lw 1 ,\
#'rslt_test/data/approx_sens.dat' u 1:2 t 'Approx Fluctuation'  w l lt 2 lc rgb '#006400' lw 3 ,\
#'rslt_test/data/chance_to_success.dat' u 1:2 t 'Chance of success'  w l lt 3 lc rgb '#006400' lw 3 ,\
#'rslt_test/data/dchi2_cl_nh_2_0.5.dat' every::0::0 u (sqrt($1)):(1-$3) notitle  w l lt 1 lc rgb 'red' lw 3 ,\
#'rslt_test/data/dchi2_cl_ih_2_0.5.dat' every::0::0 u (sqrt($1)):(1-$3):(sqrt($1-$3)):(sqrt($1+$3)):(1-($3+$4)):(1-($3-$4)) t '                   IH'  w xyerrorbars pointtype 6 lt 2 lc rgb 'red' lw 3 ,\
#'rslt_test/data/dchi2_cl_ih_2_0.5.dat' every::0::0 u (sqrt($1)):(1-$3) notitle  w l lt 2 lc rgb 'red' lw 3 ,\
#'rslt_test/data/dchi2_cl_nh_3_0.75.dat' every::0::0 u (sqrt($1)):(1-$3) notitle  w l lt 1 lc rgb 'blue' lw 3 ,\
#'rslt_test/data/dchi2_cl_ih_3_0.75.dat' every::0::0 u (sqrt($1)):(1-$3):(sqrt($1-$3)):(sqrt($1+$3)):(1-($3+$4)):(1-($3-$4)) t '                   IH'  w xyerrorbars pointtype 4 lt 2 lc rgb 'blue' lw 3 ,\
#'rslt_test/data/dchi2_cl_ih_3_0.75.dat' every::0::0 u (sqrt($1)):(1-$3) notitle  w l lt 2 lc rgb 'blue' lw 3 ,\
#'rslt_test/data/dchi2_cl_analytic_3_0.75.dat' every::0::0 u 1:3 notitle  w l lt 2 lc rgb 'blue' lw 3 ,\

reset
