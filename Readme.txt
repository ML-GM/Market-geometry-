# Code description

Paper titled "Exploiting the geometry of the heterogeneous networks: A case study of the Indian stock market"

## Reference



## Folders description

* *Comunities verses low dimensional clusters*  

  The Matlab file named as "community_cluster.m" takes data of each year as input and construct the MST network then produces the output as Newman community label of each node (C^top), cartesian coordinates of each node in the euclidean space via each dimension reduction (ISO,ncISO,LE,MCE,ncMCE), and the Cartesian coordinates of each node in poincare disc for each class of Coalescent embedding algorithm.
  This Matlab file utilises the main functions as coalescent embedding (coalescent_embedding.m) which is publicly available at the GitHub repository: https://github.com/biomedical-cybernetics/coalescent_embedding, and the Newman fast coomunity detection (Githhub link :https://github.com/ivanbrugere/matlab-networks-toolbox)
  Further, the python file "community_cluster.py" takes the input as community labels (C^top), euclidean cartesian coordinates and the cartesian coordinate of the each node in the poincare disc. This file use the poincare k-means which is publicaly available at the Githhub repository: https://github.com/AlexPof/PoincareKMeans 
  This file produces the poincare k-means cluster label (C^hyp), euclidean kmeans cluster labels (C^Euc), NMI(C^top,C^Euc), NMI(C^top,C^hyp) and AMI(C^top,C^Euc), AMI(C^top,C^hyp)
  This same code using both files can be modified (construct the MST network with 60 days window size and 1 days as rolling) for the detection of dynamics of NMI over five year dataset.
 
* *Market stability and volatility*  
    
   The Matlab file named as "stability_volatility.m" takes the input data of year 2018 and 2020 respectively, to construct the MST network with window size 60 days and 1 day as rolling and compute the geometric measures HD, HSD and topological measure SD, EW separatly for year 2018 and 2020.
   This file uses the functions from the coalescent embedding library in order to calculate these measures.

* *Original modularity and Hyperbolic modularity*

   The Matlab file named as "original_hyperbolic.m" takes the input data and construct the MST network over the five years dataset with window size 60 days and 1 day as rolling, produces the output as original modularity and the hyperbolic modularity.
   This file use the coalescent embedding and the newman fast community detection.

* *visualization of certain sectors and separation of communities*  

   The Matlab file named as "visualisation.m" takes the input data of the two sectors (finance and healthcare) or three sectors (finance, healthcare and IT) and produces the cartesian coordinate as the output of the each nodes in the poincare disc. Futher utilises the function from the coalescent_embedding repository 
   plot_embedding.m: plot the embedding of given the network, Coordinates and thier sector labels.

   The Matlab file named as "community_sepration.m" takes the input as data of each year to construct the MST network and then compute the newman fast community label of each node. futher uses, the function (angular_separation_index.m) from the coalescent embedding repository in order to evaluate the separation of the each community of the network

   angular_separation_index.m: evaluate the separation of communities over the circle circumference.

* *DATA*  
 
   This folder contains the daily log returns data as explaind in the manuscipt for 383 stocks from 2017 to 2021.
	 
## Contact

For any problem, please contact:
* Pawanesh Yadav: py506@snu.edu.in
* Charu Sharma: charu.sharma@snu.edu.in
* Niteesh Sahni: niteesh.sahni@snu.edu.in
