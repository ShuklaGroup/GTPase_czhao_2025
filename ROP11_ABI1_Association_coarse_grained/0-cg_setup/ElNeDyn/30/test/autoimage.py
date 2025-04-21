#!/home/czhao37/anaconda3/bin/ipython

import pytraj as pt
import sys

trajname   = sys.argv[1]
top        = sys.argv[2]
oname      = sys.argv[3]
spath      = sys.argv[4]

traj       = pt.load(trajname + '.xtc', top=top + '.pdb')

traj.strip(':W,ION')
traj.autoimage()
traj.center()
traj.autoimage(':1-490')
traj.save(spath + oname + '-strip.xtc')
