load('/Users/pawaneshyadav/Documents/MATLAB/DATA/Results_data(26_05_23).mat');
% load the five year dataset with 383 stocks and 939 windows
for itr=1:879
T = data(itr:itr+60-1,:); %constrcution of MST network with 60 day window size ad 1 day as rolling 
[C P]=corrcoef(T);
Ad=sqrt(2*(1-(C)));
G1=graph(Ad,'upper');
[T1, pred]=minspantree(G1,'Method','dense');
B = full(adjacency(T1));
C(find(~B))=0;  % Adjacency matrix of MST with correlation as weight
Ad(find(~B))=0; % Adjacency matrix of MST with correlation distance
[groups_hist_PM,Q_PM]=newmanCommFast(C);
Orig_Mod(itr)= max(Q_PM);   % Maximum original modularity 
 
% Embedding of the MST network in the Poincare disc
A = coalescent_embedding(Ad,'original','ISO','original',2);
dist =zeros(length(T),length(T));
for i = 1:length(T)
for j = 1:length(T)
dist(i,j) = 1./(1+hyperbolic_dist_2D(A(i,1:2), A(j,1:2))); % computation of pairwise hyperbolic distance 
end
end
dist(find(~B))=0; % replacing the edge weight with hyperbolic weight
[groups_hist_PMM,Q_PMM]=newmanCommFast(dist);
Hyp_Mod(itr)= max(Q_PM);  % Maximum Hyperbolic modularity 
end