#!/usr/bin/env python
# coding: utf-8

# # This code is intended to perform the only class ISOMAP of the coalescent embedding, in the similar way other can be replicated for each year dataset

# In[ ]:


# Important libraries 
import scipy.io
from sklearn.metrics.cluster import normalized_mutual_info_score, adjusted_mutual_info_score
import numpy as np
from poincarekmeans import PoincareKMeans
import matplotlib.pyplot as plt
### first import the matfile ("Coords_labels.mat") output of the matlab code "community_cluster", and call the Topological ##Community labels and the cartesian coordinates in euclidean space as well as poincare disc for different classes of coalescent ##embedding for example ISOMAP
mat_data = scipy.io.loadmat('/Users/pawaneshyadav/Desktop/MARCH_2024_REVISION/DATA/Coords_labels.mat')

T1 = mat_data['C_top']         # Topological Community labels
T2 = mat_data['Coal_ISO_EA']   # Cartesian coordinates of nodes in Poincaré disc via Coalecent embedding
#T2 = mat_data['Coal_ISO_CA']  # For using the circular adjustment coordinates 
T3 = mat_data['euc_ISO_coords']     # Euclidean cluster labels

Max_nmi = {}
Max_ami = {}
nmi_score = {}
ami_score = {}

for i in range(1, 6):
    nmi_scores = []
    ami_scores = []
    for itr in range(1, 1001):
        model = PoincareKMeans(n_clusters=len(np.unique(T1[:, i-1])), n_init=1, max_iter=200, tol=1e-10, verbose=True) #poincare kmeans use iterated over 1000 times
        model.fit(T2[:, 2 * i - 2:2 * i])
        clust_labels = model.labels_ + 1    # IN ORDER TO SHIFT THE SEED LABEL, SO THAT LABEL SHOULD START FROM 1 (NOT FROM 0)
        nmi_score[itr] = normalized_mutual_info_score(T1[:, i-1], clust_labels) #computation of NMI between C_top and C_hyp
        ami_score[itr] = adjusted_mutual_info_score(T1[:, i-1], clust_labels)  #computation of AMI between C_top and C_hyp
        nmi_scores.append(nmi_score[itr])
        ami_scores.append(ami_score[itr])
    
    Max_nmi[i-1] = np.max(nmi_scores) # CHOOSING THE MAXIMUM SCORE
    Max_ami[i-1] = np.max(ami_scores)


# In[ ]:


print(Max_nmi,Max_ami) # print the NMI and AMI between C_top and C_hyp


# In[ ]:

# Important libraries
from sklearn.cluster import KMeans
Max_nmiX = {}
Max_amiX = {}
for i in range(1, 6):
    nmi_scoresX = []
    ami_scoresX = []
    for itr in range(1, 1001):
        kmeans = KMeans(n_clusters=len(np.unique(T1[:, i-1])), n_init=1, max_iter=200, tol=1e-10, verbose=True) # Euclidean k-means use iterated over 1000 times
        kmeans.fit(T3[:, 2 * i - 2:2 * i])
        clust_labelsX = kmeans.labels_+1. # IN ORDER TO SHIFT THE SEED LABEL, SO THAT LABEL SHOULD START FROM 1 (NOT FROM 0)
        nmi = normalized_mutual_info_score(T1[:, i-1], clust_labelsX) #computation of NMI between C_top and C_Euc
        ami = adjusted_mutual_info_score(T1[:, i-1], clust_labelsX)  #computation of NMI between C_top and C_Euc
        nmi_scoresX.append(nmi)
        ami_scoresX.append(ami)
    
    Max_nmiX[i-1] = np.max(nmi_scoresX) # CHOOSING THE MAXIMUM SCORE
    Max_amiX[i-1] = np.max(ami_scoresX)


# In[ ]:


print(Max_nmiX, Max_amiX) # print the NMI and AMI between C_top and C_Euc

