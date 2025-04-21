import numpy as np

List = [ line.rstrip() for line in open("features/List") ]

## Get Features

def features(List):
  dataset = []
  
  for name in List:
    traj = np.load("features/" + name + "-features.npy")
    dataset.append(traj[::4])

  np.save("features_raw.npy", dataset)

  new_dataset = np.vstack(dataset)
  new_T       = np.transpose(new_dataset)

  mean = np.mean(new_T,axis=1)
  std  = np.std(new_T, axis=1)

  print(mean, std)
  results = []
  for i in range(len(dataset)):
    results.append(np.float_((dataset[i] - mean)/std))

  np.save("features_normalized.npy", np.array(results))

  ## Get RMSD

def rmsd(List):

  dataset = []

  for name in List:
    traj = np.load("features/" + name + "-rmsd.npy")
    dataset.append(traj)

  np.save("rmsd_all.npy", np.array(dataset))

if __name__ == '__main__':

  features(List)
  #rmsd(List)
