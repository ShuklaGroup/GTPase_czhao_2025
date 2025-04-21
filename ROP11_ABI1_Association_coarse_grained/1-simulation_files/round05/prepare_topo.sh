#!/bin/bash

for i in `seq 1 200`
do
mkdir topology
mkdir topology/${i}
cd topology/${i}
cp ../../${i}/PROD-01/martini*.itp .
cp ../../${i}/PROD-01/*.top .
cp ../../${i}/PROD-01/ABI1-ROP11-${i}.gro .
cp ../../${i}/PROD-01/ABI1-ROP11-${i}.ndx .
cd ../../
done
