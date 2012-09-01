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
#set yrange [1E-5:2E8]

set output "plots/flux.eps"
set title "Neutrino Flux"
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'Flux' offset 1,0
set multiplot
plot \
'flux.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "plots/noosc.eps"
set title "P_{reactor} = 20GW_{th}, L = 1km"
set xlabel 'Ev [MeV]' offset -1,0
set ylabel 'd( flux * Xsec ) / dE_v [1/s/MeV^2]' offset 1,0
set multiplot
plot \
'noosc.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "plots/xsec.eps"
set title "Neutrino-p Cross Section"
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'dXsec / dEv (cm^2/MeV)' offset 1,0
set multiplot
plot \
'xsec.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "plots/prob.eps"
set title "Oscillation Prob."
set xlabel 'Ev (MeV)' offset -1,0
set ylabel 'Prob.' offset 1,0
set multiplot
plot \
'prob.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "plots/events.eps"
set title "P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, NH, {/Symbol=\144}E_{vis}/E_{vis} = 6%/{/Symbol=\326}E_{vis}"
set xlabel 'Ev [MeV]' offset -1,0
set ylabel 'dN / dEv [1/MeV]' offset 0,0
set logscale y
set logscale x
set format y "10^%L"
set xrange [1.81:8]
set yrange [5:1E6]
#set key at 1.5,5E5 samplen 2
set xtics (2,3,4,5,6,7,8)    
set nogrid    
set parametric
set trange [5:1E6]    
const1=1.81
const2=1.87
const3=1.93
const4=2.00
const5=2.06
const6=2.13
const7=2.20
const8=2.27
const9=2.34
const10=2.42
const11=2.49
const12=2.57
const13=2.65
const14=2.73
const15=2.82
const16=2.90
const17=2.99
const18=3.08
const19=3.17
const20=3.26
const21=3.35
const22=3.45
const23=3.55
const24=3.65
const25=3.75
const26=3.85
const27=3.96
const28=4.06
const29=4.17
const30=4.28
const31=4.39
const32=4.51
const33=4.62
const34=4.74
const35=4.86
const36=4.98
const37=5.10
const38=5.23
const39=5.35
const40=5.48
const41=5.61
const42=5.74
const43=5.88
const44=6.01
const45=6.15
const46=6.29
const47=6.43
const48=6.57
const49=6.71
const50=6.86
const51=7.01
const52=7.16
const53=7.31
const54=7.46
const55=7.62
const56=7.77
const57=7.93

set multiplot
plot \
'events_10.dat' u 1:3 t '10km' w l lt 1 lc rgb 'red' lw 3 ,\
'events_20.dat' u 1:3 t '20km' w l lt 1 lc rgb 'green' lw 3 ,\
'events_30.dat' u 1:3 t '30km' w l lt 1 lc rgb 'blue' lw 3 ,\
'events_40.dat' u 1:3 t '40km' w l lt 1 lc rgb 'purple' lw 3 ,\
'events_50.dat' u 1:3 t '50km' w l lt 1 lc rgb 'cyan' lw 3 ,\
'events_60.dat' u 1:3 t '60km' w l lt 1 lc rgb 'black' lw 3 ,\
'events_70.dat' u 1:3 t '70km' w l lt 1 lc rgb 'red' lw 3 ,\
'events_80.dat' u 1:3 t '80km' w l lt 1 lc rgb 'gray' lw 3 ,\
'events_90.dat' u 1:3 t '90km' w l lt 1 lc rgb 'orange' lw 3 ,\
'events_100.dat' u 1:3 t '100km' w l lt 2 lc rgb 'purple' lw 3 ,\
const1,t notitle lt 2 lc rgb 'black' lw 1 ,\
const2,t notitle lt 2 lc rgb 'black' lw 1 ,\
const3,t notitle lt 2 lc rgb 'black' lw 1 ,\
const4,t notitle lt 2 lc rgb 'black' lw 1 ,\
const5,t notitle lt 2 lc rgb 'black' lw 1 ,\
const6,t notitle lt 2 lc rgb 'black' lw 1 ,\
const7,t notitle lt 2 lc rgb 'black' lw 1 ,\
const8,t notitle lt 2 lc rgb 'black' lw 1 ,\
const9,t notitle lt 2 lc rgb 'black' lw 1 ,\
const10,t notitle lt 2 lc rgb 'black' lw 1 ,\
const11,t notitle lt 2 lc rgb 'black' lw 1 ,\
const12,t notitle lt 2 lc rgb 'black' lw 1 ,\
const13,t notitle lt 2 lc rgb 'black' lw 1 ,\
const14,t notitle lt 2 lc rgb 'black' lw 1 ,\
const15,t notitle lt 2 lc rgb 'black' lw 1 ,\
const16,t notitle lt 2 lc rgb 'black' lw 1 ,\
const17,t notitle lt 2 lc rgb 'black' lw 1 ,\
const18,t notitle lt 2 lc rgb 'black' lw 1 ,\
const19,t notitle lt 2 lc rgb 'black' lw 1 ,\
const20,t notitle lt 2 lc rgb 'black' lw 1 ,\
const21,t notitle lt 2 lc rgb 'black' lw 1 ,\
const22,t notitle lt 2 lc rgb 'black' lw 1 ,\
const23,t notitle lt 2 lc rgb 'black' lw 1 ,\
const24,t notitle lt 2 lc rgb 'black' lw 1 ,\
const25,t notitle lt 2 lc rgb 'black' lw 1 ,\
const26,t notitle lt 2 lc rgb 'black' lw 1 ,\
const27,t notitle lt 2 lc rgb 'black' lw 1 ,\
const28,t notitle lt 2 lc rgb 'black' lw 1 ,\
const29,t notitle lt 2 lc rgb 'black' lw 1 ,\
const30,t notitle lt 2 lc rgb 'black' lw 1 ,\
const31,t notitle lt 2 lc rgb 'black' lw 1 ,\
const32,t notitle lt 2 lc rgb 'black' lw 1 ,\
const33,t notitle lt 2 lc rgb 'black' lw 1 ,\
const34,t notitle lt 2 lc rgb 'black' lw 1 ,\
const35,t notitle lt 2 lc rgb 'black' lw 1 ,\
const36,t notitle lt 2 lc rgb 'black' lw 1 ,\
const37,t notitle lt 2 lc rgb 'black' lw 1 ,\
const38,t notitle lt 2 lc rgb 'black' lw 1 ,\
const39,t notitle lt 2 lc rgb 'black' lw 1 ,\
const40,t notitle lt 2 lc rgb 'black' lw 1 ,\
const41,t notitle lt 2 lc rgb 'black' lw 1 ,\
const42,t notitle lt 2 lc rgb 'black' lw 1 ,\
const43,t notitle lt 2 lc rgb 'black' lw 1 ,\
const44,t notitle lt 2 lc rgb 'black' lw 1 ,\
const45,t notitle lt 2 lc rgb 'black' lw 1 ,\
const46,t notitle lt 2 lc rgb 'black' lw 1 ,\
const47,t notitle lt 2 lc rgb 'black' lw 1 ,\
const48,t notitle lt 2 lc rgb 'black' lw 1 ,\
const49,t notitle lt 2 lc rgb 'black' lw 1 ,\
const50,t notitle lt 2 lc rgb 'black' lw 1 ,\
const51,t notitle lt 2 lc rgb 'black' lw 1 ,\
const52,t notitle lt 2 lc rgb 'black' lw 1 ,\
const53,t notitle lt 2 lc rgb 'black' lw 1 ,\
const54,t notitle lt 2 lc rgb 'black' lw 1 ,\
const55,t notitle lt 2 lc rgb 'black' lw 1 ,\
const56,t notitle lt 2 lc rgb 'black' lw 1 ,\
const57,t notitle lt 2 lc rgb 'black' lw 1
set nomultiplot

set output "plots/flux_loe.eps"
set title "Neutrino Flux"
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'Flux' offset 1,0
set multiplot
plot \
'flux_loe.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "plots/noosc_loe.eps"
set title "Neutrino Flux"
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'Flux * Xsec' offset 1,0
set multiplot
plot \
'noosc_loe.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "plots/xsec_loe.eps"
set title "Neutrino-p Cross Section"
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'dXsec / d(L/Ev) (cm^2 MeV/km)' offset 1,0
set multiplot
plot \
'xsec_loe.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "plots/prob_loe.eps"
set title "Oscillation Prob."
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'Prob.' offset 1,0
set multiplot
plot \
'prob_loe.dat' u 1:2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

set output "plots/events_loe.eps"
set title "Event shape"
set xlabel 'L/Ev (km/MeV)' offset -1,0
set ylabel 'dN / dEv (arbitrary)' offset 1,0
set multiplot
plot \
'events_loe.dat' u 1:3 t 'NH' w l lt 1 lc rgb 'red' lw 3 ,\
'events_loe.dat' u 1:4 t 'IH' w l lt 1 lc rgb 'blue' lw 3 ,\
'events_loe.dat' u 1:2 t 'No oscillation'  w l lt 2 lc rgb 'orange' lw 3
set nomultiplot

reset
