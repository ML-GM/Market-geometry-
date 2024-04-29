load('/Users/pawaneshyadav/Documents/MATLAB/DATA/Results_data(26_05_23).mat'); %load dataset
year2017 =1:193; % row numbers for corresponding Years
year2018 =194:376; 
year2019 =377:555;
year2020 =556:751; 
year2021 =752:939;
data_year_17 = data(year2017,:); % select year for example extraction of data year2017
[C P]=corrcoef(data_year_17);
Ad=sqrt(2*(1-(C)));
G1=graph(Ad,'upper');
[T1, pred]=minspantree(G1,'Method','dense'); % MST Network construction
B1 = full(adjacency(T1));
C(find(~B1))=0; % MST adjacency matrix
Ad(find(~B1))=0; % MST distance adjacency matrix
[groups_hist_PM,Q_PM]=newmanCommFast(C);  % Newman fast community detection
[a1,b1]=max(Q_PM);
real_comm = groups_hist_PM(b1);
C_top = zeros(383,1);
for i = 1:length(real_comm{1})
    C_top(real_comm{1}{i})=i;    %C^top community label
end

% Isomap class of the coalescent embedding and conversion of the polar to
% cartesian coordinate
A = coalescent_embedding(Ad,'original','ISO','original',2); 
Coal_ISO_CA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];
A = coalescent_embedding(Ad,'original','ISO','EA',2); 
Coal_ISO_EA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];

euc_ISO_coords = isomap_graph_carlo(Ad,2,'yes');   % EUCLIDEAN EMBEDDING

clear A 

% Similaly for other like ncIsomap class of the coalescent embedding and conversion of the polar to
% cartesian coordinate
A = coalescent_embedding(Ad,'original','ncISO','original',2); 
Coal_ncISO_CA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];
A = coalescent_embedding(Ad,'original','ncISO','EA',2); 
Coal_ncISO_EA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];

euc_ncISO_coords = isomap_graph_carlo(Ad,2,'no');   % EUCLIDEAN EMBEDDING

clear A 
% LE class of the Coalescent embedding
A = coalescent_embedding(Ad,'original','LE','original',2); 
Coal_LE_CA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];
A = coalescent_embedding(Ad,'original','LE','EA',2); 
Coal_LE_EA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];


euc_LE_coords = leig_graph_carlo_classical(Ad,2,'yes');% EUCLIDEAN EMBEDDING

clear A 

% MCE class of the Coalescent embedding
A = coalescent_embedding(Ad,'original','MCE','original',2); 
Coal_MCE_CA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];
A = coalescent_embedding(Ad,'original','MCE','EA',2); 
Coal_MCE_EA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];

euc_MCE_coords = mce(Ad,2,'yes'); % EUCLIDEAN EMBEDDING

clear A 
% ncMCE class of the Coalescent embedding
A = coalescent_embedding(Ad,'original','ncMCE','original',2); 
Coal_ncMCE_CA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];
A = coalescent_embedding(Ad,'original','ncMCE','EA',2); 
Coal_ncMCE_EA = [A(:,2).*cos(A(:,1)) A(:,2).*sin(A(:,1))];

euc_ncMCE_coords = mce(Ad,2,'no'); % EUCLIDEAN EMBEDDING

clear A 

save('Coords_labels.mat', 'C_top', 'euc_ncMCE_coords', 'euc_MCE_coords', 'euc_LE_coords', ...
     'euc_ncISO_coords', 'euc_ISO_coords', 'Coal_ISO_EA', 'Coal_ISO_CA', 'Coal_ncISO_EA', ...
     'Coal_ncISO_CA', 'Coal_LE_EA', 'Coal_LE_CA', 'Coal_MCE_EA', 'Coal_MCE_CA', ...
     'Coal_ncMCE_EA', 'Coal_ncMCE_CA');
