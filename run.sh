#!/bin/bash
eps=$1
make fft >/dev/null 2>&1
L=("10" "20" "30" "40" "50" "60" "100" "150" "200" "250" "300")
#L=("60")
#nL=1
nL=11
gnu_file=fft_nor_inv.gnu
i=0
while [ $i -ne $nL ]; do
    ./fft $eps ${L[$i]}
    echo "set terminal postscript eps enhanced 'Times-Roman' color 17" > $gnu_file
    echo "#set logscale x" >> $gnu_file
    echo "#set logscale y" >> $gnu_file
    echo "#set format x '%L'" >> $gnu_file
    echo "#set format y '%L'" >> $gnu_file
    echo "#set xtics (0.001,0.01)" >> $gnu_file
    echo "#set ytics (1,10,1E2)" >> $gnu_file
    echo "#set tics scale 2" >> $gnu_file
    echo "set grid" >> $gnu_file
    echo "#set key at 1.0E3,1.0E7 samplen 2" >> $gnu_file
    echo "#set key spacing 1.5" >> $gnu_file
    echo "#set xlabel 'cost' offset -1,0" >> $gnu_file
    echo "#set ylabel 'log_{/=10 10} L (Mpc)' offset 1,0" >> $gnu_file
    echo "#set xrange [-1:1]" >> $gnu_file
    echo "#set yrange [1E-5:2E8]" >> $gnu_file
    echo "" >> $gnu_file
    echo "set output 'plots/fct_nor_inv_${eps}_${L[$i]}.eps'" >> $gnu_file
    echo "set xlabel '${L[$i]} km   dE/E = $eps %' offset -1,0" >> $gnu_file
    echo "set multiplot" >> $gnu_file
    echo "plot \\" >> $gnu_file
    echo "'fct_nor.dat' u 1:2 t 'FCT: NH'  w l lt 1 lc rgb 'red' lw 3 ,\\" >> $gnu_file
    echo "'fct_nor.dat' u 1:3 t 'err +'  w l lt 2 lc rgb 'red' lw 1 ,\\" >> $gnu_file
    echo "'fct_nor.dat' u 1:4 t 'err -'  w l lt 3 lc rgb 'red' lw 1 ,\\">> $gnu_file
    echo "'fct_inv.dat' u 1:2 t 'IH'  w l lt 1 lc rgb 'blue' lw 3 ,\\">> $gnu_file
    echo "'fct_inv.dat' u 1:3 t 'err +'  w l lt 2 lc rgb 'blue' lw 1 ,\\" >> $gnu_file
    echo "'fct_inv.dat' u 1:4 t 'err -'  w l lt 3 lc rgb 'blue' lw 1" >> $gnu_file
    echo "set nomultiplot" >> $gnu_file
    echo "set xlabel '${L[$i]} km   dE/E = $eps %' offset -1,0" >> $gnu_file
    echo "set output 'plots/fst_nor_inv_${eps}_${L[$i]}.eps'" >> $gnu_file
    echo "plot \\" >> $gnu_file
    echo "'fst_nor.dat' u 1:2 t 'FST: NH'  w l lt 1 lc rgb 'red' lw 3 ,\\" >> $gnu_file
    echo "'fst_nor.dat' u 1:3 t 'err +'  w l lt 2 lc rgb 'red' lw 1 ,\\" >> $gnu_file
    echo "'fst_nor.dat' u 1:4 t 'err -'  w l lt 3 lc rgb 'red' lw 1 ,\\">> $gnu_file
    echo "'fst_inv.dat' u 1:2 t 'IH'  w l lt 1 lc rgb 'blue' lw 3 ,\\">> $gnu_file
    echo "'fst_inv.dat' u 1:3 t 'err +'  w l lt 2 lc rgb 'blue' lw 1 ,\\" >> $gnu_file
    echo "'fst_inv.dat' u 1:4 t 'err -'  w l lt 3 lc rgb 'blue' lw 1" >> $gnu_file
    echo "set nomultiplot" >> $gnu_file
    echo "reset" >> $gnu_file
    gnuplot $gnu_file
    i=`expr $i + 1`
done

#cp fft_nor_inv_tmp.gnu fft_nor_inv.gnu
#sed -e 's/SEDL/$L' \
#    -e 's/SEDEPS/$eps' fft_nor_inv.gnu > tmp.gnu
#mv tmp.gnu fft_nor_inv.gnu
