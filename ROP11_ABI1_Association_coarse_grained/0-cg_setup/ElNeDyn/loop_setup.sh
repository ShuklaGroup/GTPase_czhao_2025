#!/bin/bash

for i in `seq 2 50`
do

mkdir $i; cd $i
cp ../setup.sh .
sed "s/ROP11-ABI1-1/ROP11-ABI1-${i}/g" setup.sh > temp.sh
sed "s/ABI1-ROP11-1/ABI1-ROP11-${i}/g" temp.sh  > setup.sh
source setup.sh
cd ..

done 
