#!/bin/bash

round=5
parallel=400
total=3

echo "# round ${round}" > List
echo "# parallel ${parallel}"    >> List
echo "# total ${total}" >> List

for i in `seq 1 1`
#${parallel}`
do
  cd ${i}
  path=$(pwd)
  oPath=/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0${round}/trajs_full/
 
  cd PROD-01
  gmx_mpi_d editconf -f ../PROD-01/ABI1-ROP11-${i}.gro -o ../ABI1-ROP11-${i}.pdb
  ../../autoimage.py ABI1-ROP11-${i}-rnd1 ../ABI1-ROP11-${i} ABI1-ROP11-${round}-${i}-1 ${oPath}
  rm ABI1-ROP11-${i}-rnd1.xtc
  cd ..

  for t in `seq 2 ${total}`
  do
    cd PROD-0${t}
    ../../autoimage.py ABI1-ROP11-${i}-rnd${t}.part000${t} ../ABI1-ROP11-${i} ABI1-ROP11-${round}-${i}-${t} ${oPath}
    rm ABI1-ROP11-${i}-rnd${t}.part000${t}.xtc
    cd ..
  done

  cd ..
done
