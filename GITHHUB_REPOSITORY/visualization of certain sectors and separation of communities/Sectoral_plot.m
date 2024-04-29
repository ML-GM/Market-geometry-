load('/Users/pawaneshyadav/Documents/MATLAB/DATA/Results_data(26_05_23).mat'); % load dataset saved as TT variable
data = TT;

load('Sectoral_labels.mat') % load sectoral labels as saved variable ST
F_H = [find(ST==1); find(ST==2)]; %extraction of the sectoral labels of finance and healthcare
% F_H_IT = [find(ST==1); find(ST==2);find(ST==8)]; % extraction of the
% sectoral labels of finance, healthcare and IT

DATA_F_H = data(:,F_H);      % Filtering data corresponding to these two sectors
% DATA_F_H_IT = data(:,F_H_IT);      % Filtering data corresponding to these three sectors

[C P]=corrcoef(DATA_F_H); 
D=sqrt(2*(1-abs(C)));
G=graph(D,'upper');
[T1, pred]=minspantree(G,'Method','dense');
B = full(adjacency(T1));
C(find(~B))=0; % MST adjacency matrix
Ad(find(~B))=0; % MST distance adjacency matrix
% Colescent embedding with CA angular adjustment
A = coalescent_embedding(Ad,'original','ISO','original',2); 
figure
plot_embedding(B,A,'labels',F_H)

% Colescent embedding with EA angular adjustment
A = coalescent_embedding(Ad,'original','ISO','EA',2); 
figure
plot_embedding(B,A,'labels',F_H)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For the visulaisation of the three sectors just uncomment above variable
% "F_H_IT", "DATA_F_H_IT" and also replace the labels in the plot_embedding function.
