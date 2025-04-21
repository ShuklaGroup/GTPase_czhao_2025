import numpy as np
from msmbuilder.utils import io
from collections import Counter, deque

List     = [ line.rstrip() for line in open("List", "r") ]
endList  = [ line.rstrip() for line in open("endList", "r") ]

cl       = io.load("clustering_tica_600_mapped.pkl")

cl_count = Counter(np.hstack(cl))
cl_count = sorted(cl_count.items(), key=lambda x: x[1])

print("Top clusters with the highest populations")
for i in range(-20, 0, 1): 
    print(cl_count[i])

endList     = deque(endList)

topstates = []
sum       = 0
for i, name in enumerate(List):
        #if name == endList[0]:
        #endList.popleft()
        if 45 in cl[i] and 240 in cl[i]:
        #if cl[i][-1] in [160, 464, 7]:
            print(name)
        if 160 in cl[i] or 464 in cl[i] or 7 in cl[i]:
            sum += 1
        topstates.append(cl[i][-1])

print(sum)
print(len(topstates))

from collections import Counter

count = Counter(np.hstack(topstates))

count = sorted(count.items(), key=lambda x: x[1])
 
print("Top clusters with the highest counts")
for i in range(-40, 0, 1): print(count[i])
