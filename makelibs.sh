#!/bin/bash

rm -rf lib/*

cd DeltaChi2
make clean
make
cd ..

cd minuit_f
make clean
make
cd ..

cd mylib
make clean
make
cd ..