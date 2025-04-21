import numpy as np
from collections import Counter, defaultdict
import mdtraj as md
import pickle, os

### Load the data
frames    = defaultdict(list)
cl        = pickle.load(open('../cluster/clustering_500.pkl', 'rb'))
cl_label  = cl.labels_
counts    = Counter(np.hstack(cl_label))
List = [ line.rstrip() for line in open('../cluster/features/List', 'r') ]

for i in range(len(cl_label)):
  for j in range(len(cl_label[i])):
    frames[cl_label[i][j]].append([i,j])

def extract(name, frame, id):
  ### Add code to parse name
  locs     = name.split('-')[-3:]
  r, p, t  = locs[0], locs[1], locs[2]
  path     = "/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0" + str(r) + "/" + str(p) + "/"
  top      = path + "PROD-01/ABI1-ROP11-" + str(p)
  path     = path + "PROD-0" + str(t)
  if t == '1':
    trajname = path + "/ABI1-ROP11-" + str(p) + "-rnd" + str(t)
  else:
    trajname = path + "/ABI1-ROP11-" + str(p) + "-rnd" + str(t) + ".part000" + str(t)
  traj       = md.load(trajname + '.xtc', top=top + '.gro', frame = frame)

  ### Output data
  ornd     = 4
  oname    = "ABI1-ROP11-" + str(id)
  opath    = "/home/czhao37/7-GTPase/coarse-grained/round0" + str(ornd)
  os.system("mkdir " + opath)
  opath    = opath + "/" + str(id)
  os.system("mkdir " + opath)
  opath    = opath + "/PROD-01"
  os.system("mkdir " + opath)
  traj.save(opath + "/" + oname + ".gro")
  path = "/home/czhao37/ds02/GTPase-coarse-grain/coarse-grain/round0" + str(r) + "/" + str(p) + "/PROD-01"
  os.system("cp " + path + "/martini_v2.0_ions.itp " + opath + "/")
  os.system("cp " + path + "/martini_v2.2.itp " + opath + "/")
  os.system("cp " + path + "/Protein_A.itp " + opath + "/")
  os.system("cp " + path + "/Protein.itp "   + opath + "/")
  os.system("cp " + path + "/ABI1-ROP11-" + str(p) + ".top " + opath + "/")

id = 1
for i in sorted(counts.values())[0:200]:
  state  = list(counts.values()).index(i)
  select = np.random.choice(range(0,len(frames[state])), size=1)
  frame  = frames[state][select[0]]
  extract(List[frame[0]], frame[1], id)
  id += 1
