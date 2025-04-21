#!/bin/bash

for i in `seq 1 400`
do

cd ${i}

cp ../*.itp .
head -4 ../*.top > ABI1-ROP11-${i}-VIZ.top
tail -12 ABI1-ROP11-${i}.top | head -6 >> ABI1-ROP11-${i}-VIZ.top
echo "Protein+Protein_A 1"    >> ABI1-ROP11-${i}-VIZ.top
tail -4 ABI1-ROP11-${i}.top  >> ABI1-ROP11-${i}-VIZ.top
gmx_mpi_d grompp -p ABI1-ROP11-${i}-VIZ.top -c ABI1-ROP11-${i}.gro -f ../minimization.mdp -o ABI1-ROP11-${i}.tpr
echo q | gmx_mpi_d make_ndx -f ABI1-ROP11-${i}.gro
cat ../temp.ndx >> index.ndx
mv index.ndx ABI1-ROP11-${i}.ndx
cd ..

done 
