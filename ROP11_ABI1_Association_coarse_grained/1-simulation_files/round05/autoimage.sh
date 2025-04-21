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
  path=$(pwd)
  pPath=/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0${round}/topology/${i}
  oPath=/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0${round}/trajs_strip
  tPath=/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0${round}/trajs_full
 
  cd ${path}

  for t in `seq 1 ${total}`
  do 
    echo 15 | gmx_mpi_d trjconv -s ${pPath}/ABI1-ROP11-${i}.tpr -f ${tPath}/ABI1-ROP11-${round}-${i}-${t}.xtc -pbc whole -o ${oPath}/ABI1-ROP11-1-${i}-${t}.xtc -n ${pPath}/ABI1-ROP11-${i}.ndx
  done
done
