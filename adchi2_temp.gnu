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

set output "plots/adchi2_LLL.eps"
set title "P_{reactor} = PPPGW_{th}, V = VVVkton (RRR% free proton), YYY years, LLL km"
set xlabel 'E_{/Symbol=\156} [MeV]' offset -1,0
set ylabel 'Del chi2' offset 0,0
#set logscale y
set logscale x
#set format y "10^%L"
set xrange [1.81:8]
#set key at 1.5,5E5 samplen 2
set xtics (2,3,4,5,6,7,8)    
set nogrid    
set parametric
set trange [0:1.5]    
const1=1.81
const2=1.8712
const3=1.9342
const4=1.999
const5=2.0656
const6=2.134
const7=2.2042
const8=2.27619
const9=2.34999
const10=2.42559
const11=2.50229
const12=2.58219
const13=2.66319
const14=2.74599
const15=2.83059
const16=2.91699
const17=3.00519
const18=3.09519
const19=3.18699
const20=3.28059
const21=3.37599
const22=3.47318
const23=3.57218
const24=3.67298
const25=3.77558
const26=3.87998
const27=3.98618
const28=4.09418
const29=4.20398
const30=4.31558
const31=4.42898
const32=4.54418
const33=4.66118
const34=4.77998
const35=4.90057
const36=5.02297
const37=5.14717
const38=5.27317
const39=5.40097
const40=5.53057
const41=5.66197
const42=5.79517
const43=5.93017
const44=6.06697
const45=6.20557
const46=6.34597
const47=6.48817
const48=6.63216
const49=6.77796
const50=6.92556
const51=7.07496
const52=7.22616
const53=7.37916
const54=7.53396
const55=7.69056
const56=7.84896

set multiplot
plot 'adchi2_fit2nh_LLL_6.dat' u ($1**2+0.8):2 title 'fit to NH' w l lt 1 lc rgb 'red' lw 1
#plot 'adchi2_fit2ih_LLL_6.dat' u ($1**2+0.8):2 title 'fit to IH' w l lt 1 lc rgb 'blue' lw 1
set nomultiplot

reset
