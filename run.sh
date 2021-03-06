#!/bin/bash
if [[ "$1" == "-h" ]]; then
    echo ""
    echo "Usage: run.sh [run_name] [Eres_a] [Eres_b]"
    echo ""
    exit
fi
selfdir=$(cd $(dirname $0);pwd)

############ Setting argument values ################################
run=$1 # Name of this program runing (It will be used as the name of a directory (e.g. rslt_test for run=test), where running results are output)

Eres_a=$2 # [%] Energy resolution of a detector (statistical "a" parameter (cf. 1210.8141)) 
Eres_b=$3 # [%] Energy resolution of a detector (non-statistical "b" parameter (cf. 1210.8141)) 

############### internal parameters ######################
P=16.4 # [GW] Total thermal power of a nuclear plant
V=18   # [kton] Size of a detector
R=0.12 # Proton weight-ratio in a detector scintillator
Y=5    # [years] running time of an experiment

Lmin=10  # [km] minimum baseline length (L) for the baseline length scan
Lmax=100 # [km] maximum baseline length (L) for the baseline length scan (Only valid for iLscan=1)
ndiv=20  # The number of pseudo-experiments (for iLscan = 0)
         # The number of division for the baseline length scan (for iLscan = 1)

binsize_factor=0.0025 # Bin size for chi^2 minimization. (Bin size) =  binsize_factor * sqrt{E_vis} (E_vis in [MeV]). binsize_factor = 0.0025 is used in 1210.8141.

######## Switches #############
mode=0 # 0:Perform dchi^2 minimization 

iLscan=0 # Switch for baseline-length scan
         #   0: Perform baseline-length scan for dchi^2_min from Lmin to Lmax with (ndiv +1) scanning points. 
         #   1: Evaluate dchi^2_min for a baseline length set by Lmin 

ifluc=0 # Switch for data fluctuation
        #   0: Data fluctuation is not included. ( [Observed event number] = [Theoretically predicted event number] for each bin ) 
        #   1: Data fluctuation is included. (Observed event number in each bin is fluctuated by a Gaussian distribution around a theoretical Prediction.
        #      The variance of the Gaussian is the observed event number.)
        # In this program, we first calculate "Observed" event numbers for bins in reconstruted neutrino energy (Erec). 
        # Next we calculate "Predicted" event numbers and perform chi^2 minimization for a parameter fitting. 

ixsec=1 # Switch for Inverse beta decay (IBD) cross section treatment
        #   0: Include Nulear recoil effect (approx) 
        #   1: Neglect the recoil effect 

iPee=0 # Switch for different mass difference squared parameterizations 
       #   0: dm31_2-dm32_2 parametreization
       #   1: dmee_2 parameterization

########## main program #############################
#-----Initialization 
make clean >/dev/null 2>&1
rm -rf plots/*
rm -rf data/*
start_time=`date '+%s'`
date=`date '+%Y/%m/%d'`
ttime=`date '+%T'`
echo ${date} ${ttime}

run_dir=rslt_${run}
defout=${run_dir}/summary.txt

if [ -e ${run_dir} ]; then
    echo "run directory exists. The files will be overwritten."
else
    mkdir ${run_dir}
fi

echo ${date} ${ttime} > ${defout}

echo "" >> ${defout}
echo "[Input Parameters]" >> ${defout}
echo "Reactor Power:" $P "GW_{th}" >> ${defout}
echo "Detector Volume:" $V "kton" >> ${defout}
echo "Free Proton Weight Fraction:" $R >> ${defout}
echo "Exposure time:" $Y "year" >> ${defout}

cd DeltaChi2
make
cd ..
make dchi2
make get_cl

#----------- dchi^2 Analyses
mode=0
./dchi2 $Lmin $Lmax $ndiv $P $V $R $Y ${Eres_a} ${Eres_b} ${mode} ${iLscan} ${ifluc} ${binsize_factor} ${ixsec} ${iPee}
############### Finishing mainprogram ###################
mv *.dat data/.
cp -rf data ${run_dir}/.

################ Timing ##################################
end_time=`date '+%s'`
SS=`expr ${end_time} - ${start_time}` 
HH=`expr ${SS} / 3600` 
SS=`expr ${SS} % 3600` 
MM=`expr ${SS} / 60` 
SS=`expr ${SS} % 60` 
elapsed_time="${HH}:${MM}:${SS}" 
echo "Elapsed time:" $elapsed_time
echo "" >> ${defout}
echo "total time = " $elapsed_time >> ${defout}

echo ""
echo `date '+%T'`