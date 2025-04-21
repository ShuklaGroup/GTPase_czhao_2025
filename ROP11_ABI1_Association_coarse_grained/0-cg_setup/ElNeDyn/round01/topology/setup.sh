#!/bin/bash

path=$(pwd)

for i in `seq 1 50`
do

input=ABI1-ROP11-${i}

mkdir ${i}; cd ${i}
mkdir PROD-01; cd PROD-01
cp ../../../${i}/*.itp .
cp ../../../${i}/${input}.top .
cp ../../../${i}/equilibration.gro ${input}.gro
cp ../../../${i}/VIZ/${input}.tpr .
cp ../../../${i}/VIZ/${input}.ndx .

cd ${path}

done 
