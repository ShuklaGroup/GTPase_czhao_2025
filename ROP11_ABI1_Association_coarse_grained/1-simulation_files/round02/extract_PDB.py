import numpy as np
from collections import defaultdict
import mdtraj as md

rnd    = 1
frames = defaultdict(list)
cl     = np.load("cl_labels.npy")

for i in range(len(cl)):
  for j in range(len(cl[i])):
    for k in range(len(cl[i][j])):
      frames[cl[i][j][k]].append([i,j,k])

def extract(state, locs, id):
  for i, loc in enumerate(locs):
    par, t, frame = str(loc[0]+1), str(loc[1]+1), str(loc[2])
    top        = "/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0" + str(rnd) + "/" + str(par) + "/PROD-01/ABI1-ROP11-" + str(par) + ".gro"    
    if t == '1':
      trajname = "/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0" + str(rnd) + "/" + str(par) + "/PROD-0" + str(t) + "/ABI1-ROP11-"\
											   + str(par) + "-rnd" + str(t) + ".xtc"
    else:
      trajname = "/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0" + str(rnd) + "/" + str(par) + "/PROD-0" + str(t) + "/ABI1-ROP11-"\
                                                                                           + str(par) + "-rnd" + str(t) + ".part000" + str(t) + ".xtc"
    output   = str(id) + "/PROD-01/ABI1-ROP11-" + str(id) + ".gro"
    traj     = md.load(trajname, top=top, frame = loc[2])
    traj.save(output)

import os
def copy_files(state, locs, id):
  loc = locs[0]
  par, t = str(loc[0]+1), str(loc[1]+1)
  topo_path = "/home/czhao37/7-GTPase/coarse-grained/round0" + str(rnd) + "/topology/" + str(par) + "/PROD-01/"
  os.system("cp " + topo_path + "Protein.itp " + str(id) + "/PROD-01")
  os.system("cp " + topo_path + "Protein_A.itp " + str(id) + "/PROD-01")
  os.system("cp " + topo_path + "martini_v2.0_ions.itp " + str(id) + "/PROD-01")
  os.system("cp " + topo_path + "martini_v2.2.itp " + str(id) + "/PROD-01")
  os.system("cp " + topo_path + "ABI1-ROP11-" + str(par) + ".top " + str(id) + "/PROD-01/ABI1-ROP11-" + str(id) + ".top")
  os.system("cp " + topo_path + "ABI1-ROP11-" + str(par) + ".ndx " + str(id) + "/PROD-01/ABI1-ROP11-" + str(id) + ".ndx")

states = []
for i in sorted(frames.values()):
  states.append(list(frames.keys())[list(frames.values()).index(i)])

id = 1
for i in states:
  selects = np.random.choice(range(0,len(frames[i])), size=1)
  selects = [ frames[i][j] for j in selects ]
  extract(i, selects, id)
  copy_files(i, selects, id)
  id += 1
