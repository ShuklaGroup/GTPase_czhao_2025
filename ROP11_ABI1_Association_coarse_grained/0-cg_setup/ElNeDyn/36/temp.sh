#!/bin/bash

pdb=ROP11-ABI1-36
out=ABI1-ROP11-1

### Setup martinize topology files 
martinize -f ../../packmol/${pdb}.pdb -o ${out}.top -x ${out}.pdb -ss ../../dssp/ABI1-ROP11.dssp -p backbone -ff elnedyn22

### Copy martini force field parameters and modify topology
cp /Users/chuankai/0-Research/4-Plant-Hormones/8-GTPase/coarse-grained/scripts/martini_v2.2.itp .
sed 's/martini.itp/martini_v2.2.itp/g' ${out}.top  > temp
mv temp ${out}.top

### Add Mg2+ ions to coordinate files
cp /Users/chuankai/0-Research/4-Plant-Hormones/8-GTPase/coarse-grained/scripts/martini_v2.0_ions.itp .
sed '1 a\
#include "martini_v2.0_ions.itp"' ${out}.top > temp
mv temp ${out}.top
echo "MG+              2" >> ${out}.top
grep "MG   MG" ../../packmol/${pdb}.pdb > temp
sed "s/MG   MG/MG  MG+/g" temp > new_temp; mv new_temp temp
head -1075 ${out}.pdb > temp.pdb
head -1 temp >> temp.pdb  
echo "TER"   >> temp.pdb
tail -1 temp >> temp.pdb
echo "TER"   >> temp.pdb
tail -1 ${out}.pdb >> temp.pdb
mv temp.pdb ${out}.pdb

### Solvate the protein structure
cp /Users/chuankai/0-Research/4-Plant-Hormones/8-GTPase/coarse-grained/scripts/minimization.mdp .
cp /Users/chuankai/0-Research/4-Plant-Hormones/8-GTPase/coarse-grained/scripts/water.gro .
gmx editconf -f ${out}.pdb -o ${out}.gro -d 2.2 -bt cubic
gmx grompp -f minimization.mdp -c ${out}.gro -p ${out}.top -o minimization-vac.tpr
gmx mdrun -deffnm minimization-vac -v 
gmx solvate -cp minimization-vac.gro -cs water.gro -radius 0.21 -o solvated.gro
num=`grep W solvated.gro | wc -l`
echo "W            ${num}" >> ${out}.top
gmx grompp -f minimization.mdp -c solvated.gro -p ${out}.top -o minimization.tpr
gmx mdrun -deffnm minimization -v

### Add ions
cp /Users/chuankai/0-Research/4-Plant-Hormones/8-GTPase/coarse-grained/scripts/equilibration.mdp .
gmx grompp -f equilibration.mdp -c minimization.gro -p ${out}.top -o equilibration.tpr -maxwarn 1
echo 15 | gmx genion -s equilibration.tpr -nn 31 -nname CL- -np 30 -pname NA+ -p ${out}.top -o ${out}.gro
gmx grompp -f equilibration.mdp -c ${out}.gro -p ${out}.top -o equilibration.tpr -maxwarn 2
gmx mdrun -deffnm equilibration -v
