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
#set yrange [0:1E-33]

set output "plots/Xsec.eps"
#set title "P_{reactor} = PPPGW_{th}, L = LLLkm"
set xlabel 'E_{/Symbol=\156} [MeV]' offset -1,0
set ylabel 'dXsec / dE_{/Symbol=\156} [/MeV]' offset 1,0
set multiplot
plot \
'DATADIR/Xsec.dat' u ($1**2+0.8):2 notitle  w l lt 1 lc rgb 'red' lw 3
set nomultiplot

reset
