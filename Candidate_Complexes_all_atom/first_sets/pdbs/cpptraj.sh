#!/bin/bash

path=$(pwd)

while read line
do

cat > ${line}.in << EOF
parm ../0-Minimization/${line}.prmtop
EOF
echo "trajin ../PROD-05/${line}.rst" >> ${line}.in
echo "center"    >> ${line}.in
echo "autoimage" >> ${line}.in
echo "strip :Na+,Cl-,WAT" >> ${line}.in
echo "trajout ${line}.pdb" >> ${line}.in

done < List

while read line
do
cpptraj.OMP -i ${line}.in
done < List
