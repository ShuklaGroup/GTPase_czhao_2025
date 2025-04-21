#!/bin/bash

for i in `seq 1 400`
do

cp ${i}/PROD-03/ABI1-ROP11-${i}-rnd3.part0003.gro trajs_full/ABI1-ROP11-5-${i}-1.gro
cp ${i}/PROD-03/ABI1-ROP11-${i}-rnd3.part0003.gro trajs_full/ABI1-ROP11-5-${i}-2.gro
cp ${i}/PROD-03/ABI1-ROP11-${i}-rnd3.part0003.gro trajs_full/ABI1-ROP11-5-${i}-3.gro

done

