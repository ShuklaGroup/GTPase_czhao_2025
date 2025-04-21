#!/bin/bash

path=$(pwd)

while read line
do

cat > ${line}.in << EOF
parm ../0-Minimization/${line}.prmtop
EOF
if [ -f ../PROD-01/${line}.mdcrd ] 
then
echo "trajin ../PROD-01/${line}.mdcrd" >> ${line}.in
fi
if [ -f ../PROD-02/${line}.mdcrd ]
then
echo "trajin ../PROD-02/${line}.mdcrd" >> ${line}.in
fi
if [ -f ../PROD-03/${line}.mdcrd ]
then 
echo "trajin ../PROD-03/${line}.mdcrd" >> ${line}.in
fi
if [ -f ../PROD-04/${line}.mdcrd ]
then
echo "trajin ../PROD-04/${line}.mdcrd" >> ${line}.in
fi 
if [ -f ../PROD-05/${line}.mdcrd ]
then
echo "trajin ../PROD-05/${line}.mdcrd" >> ${line}.in
fi
echo "center" >> ${line}.in
echo "autoimage" >> ${line}.in
echo "trajout ${line}.dcd" >> ${line}.in

cat > ${line}_traj.in << EOF
parm ../0-Minimization/${line}.prmtop
EOF
if [ -f ../PROD-01/${line}.mdcrd ]
then
echo "trajin ../PROD-01/${line}.mdcrd" >> ${line}_traj.in
fi
if [ -f ../PROD-02/${line}.mdcrd ]
then
echo "trajin ../PROD-02/${line}.mdcrd" >> ${line}_traj.in
fi
if [ -f ../PROD-03/${line}.mdcrd ]
then
echo "trajin ../PROD-03/${line}.mdcrd" >> ${line}_traj.in
fi
if [ -f ../PROD-04/${line}.mdcrd ]
then
echo "trajin ../PROD-04/${line}.mdcrd" >> ${line}_traj.in
fi
if [ -f ../PROD-05/${line}.mdcrd ]
then
echo "trajin ../PROD-05/${line}.mdcrd" >> ${line}_traj.in
fi
echo "center" >> ${line}_traj.in
echo "autoimage" >> ${line}_traj.in
echo "strip :Na+,Cl-,WAT" >> ${line}_traj.in
echo "trajout ${line}_strip.dcd" >> ${line}_traj.in

cat > ${line}_parm.in << EOF
parm ../0-Minimization/${line}.prmtop
parmstrip :WAT,Na+,Cl-
parmwrite out ${line}_strip.prmtop
EOF

done < List

while read line
do
cpptraj.OMP -i ${line}.in
cpptraj.OMP -i ${line}_traj.in
cpptraj.OMP -i ${line}_parm.in
done < List
