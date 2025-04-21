#!/bin/bash

path=$(pwd)
rnd=3

for i in `seq 1 100`
do
input=ABI1-ROP11-${i}
cd ${i}
mkdir PROD-0${rnd}
cd PROD-0${rnd}
work_dir=$(pwd)

cat > PBS_${input}_rnd${rnd} << EOF
#!/bin/bash
#PBS -l nodes=1:ppn=32:xe
#PBS -l walltime=47:45:00
#PBS -q low
#PBS -A bave

source /u/sciteam/zhao1/gromacs/gromacs-2019/install-cpu/bin/GMXRC
export OMP_NUM_THREADS=1

cd ${work_dir}
aprun -n 1 -N 1 -d 1 /u/sciteam/zhao1/gromacs/gromacs-2019/install-cpu/bin/gmx_mpi convert-tpr -s ../PROD-0$(( ${rnd} - 1 ))/${input}-rnd$(( ${rnd} - 1 )).tpr -extend 3000000 -o ${input}-rnd${rnd}.tpr 
aprun -n 32 -N 32 -d 1 /u/sciteam/zhao1/gromacs/gromacs-2019/install-cpu/bin/gmx_mpi mdrun -deffnm ${input}-rnd${rnd} -s ${input}-rnd${rnd}.tpr -cpi ../PROD-0$(( ${rnd} - 1 ))/${input}-rnd$(( ${rnd} - 1 )).cpt -noappend

EOF

#sleep 2m

qsub PBS_${input}_rnd${rnd}

cd ${path}
done 
