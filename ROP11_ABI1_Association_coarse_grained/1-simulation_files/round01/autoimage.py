#!/home/czhao37/anaconda3/envs/ambermd/bin/python

import pytraj as pt
import sys

trajname   = sys.argv[1]
top        = sys.argv[2]
oname      = sys.argv[3]
opath      = sys.argv[4]

traj       = pt.load(trajname + '.xtc', top=top + '.pdb')

traj.autoimage()
traj.autoimage(':1-649')
traj.autoimage(':1-1045')
traj.save(opath + oname + '.xtc', overwrite=True)
