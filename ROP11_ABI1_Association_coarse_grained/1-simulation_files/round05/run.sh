#!/bin/bash

path=$(pwd)
rnd=1

for i in `seq 1 200`
do
input=ABI1-ROP11-${i}
cd ${i}/PROD-0${rnd}
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
aprun -n 1 -N 1 -d 1 /u/sciteam/zhao1/gromacs/gromacs-2019/install-cpu/bin/gmx_mpi grompp -f ${path}/input/MD-PROD.mdp -c ${input}.gro -p ${input}.top -o ${input}-rnd${rnd}.tpr -maxwarn 2
aprun -n 32 -N 32 -d 1 /u/sciteam/zhao1/gromacs/gromacs-2019/install-cpu/bin/gmx_mpi mdrun -deffnm ${input}-rnd${rnd} -v 
EOF

qsub PBS_${input}_rnd${rnd}

cd ${path}
done 
