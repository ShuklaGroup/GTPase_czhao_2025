#!/bin/bash

path=$(pwd)

for i in `seq 1 50`
do

pdb=ROP11-ABI1-${i}
out=ABI1-ROP11-${i}

cd ${i}
mkdir VIZ
cd VIZ

martinize -f ../../../packmol/${pdb}.pdb -o ${out}.top -x ${out}.pdb -ss ../../../dssp/ABI1-ROP11.dssp -p backbone -ff elnedyn22 -merge ,A

### Modify top file
cp ../martini_v2.2.itp .
cp ../martini_v2.0_ions.itp .

echo '#include "martini_v2.2.itp"' > ${out}.top
echo '#include "martini_v2.0_ions.itp"' >> ${out}.top
echo '#define RUBBER_BANDS' >> ${out}.top
echo '#include "Protein+Protein_A.itp"' >> ${out}.top

echo '[ system ]' >> ${out}.top
echo '; name'     >> ${out}.top
echo "Martini system from ../../../packmol/${pdb}.pdb"     >> ${out}.top

echo '[ molecules ]' >> ${out}.top
echo '; name        number'   >> ${out}.top
echo 'Protein+Protein_A   1'  >> ${out}.top
tail -4 ../${out}.top >> ${out}.top

gmx grompp -p ${out}.top -c ../equilibration.gro -f ../minimization.mdp -o ${out}.tpr

echo q | gmx make_ndx -f ../equilibration.gro 

cat ../../index.ndx >> index.ndx
mv index.ndx ${out}.ndx

cd ${path}

done 

