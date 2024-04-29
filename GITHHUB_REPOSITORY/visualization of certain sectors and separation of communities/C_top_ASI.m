load('/Users/pawaneshyadav/Documents/MATLAB/DATA/Results_data(26_05_23).mat'); %load dataset
year2017 =1:193; % row numbers for corresponding Years
year2018 =194:376; 
year2019 =377:555;
year2020 =556:751; 
year2021 =752:939;
data_year_17 = data(year2017,:); % extraction of data for a year i.e year2017
[C P]=corrcoef(data_year_17);
Ad=sqrt(2*(1-(C)));
G1=graph(Ad,'upper');
[T1, pred]=minspantree(G1,'Method','dense'); % MST Network construction
B1 = full(adjacency(T1));
C(find(~B1))=0; % MST adjacency matrix weight as correlation
Ad(find(~B1))=0; % MST distance adjacency matrix with correlation distance
[groups_hist_PM,Q_PM]=newmanCommFast(C);  % Newman fast community detection
[a1,b1]=max(Q_PM);
real_comm = groups_hist_PM(b1);
C_top = zeros(383,1);
for i = 1:length(real_comm{1})
    C_top(real_comm{1}{i})=i;    %C^top community label
end

% Isomap class of the coalescent embedding and conversion of the polar to
% cartesian coordinate
A1 = coalescent_embedding(Ad,'original','ISO','EA',2); 
A2 = coalescent_embedding(Ad,'original','ncISO','EA',2);
A3 = coalescent_embedding(Ad,'original','LE','EA',2); 
A4 = coalescent_embedding(Ad,'original','MCE','EA',2);
A5 = coalescent_embedding(Ad,'original','ncMCE','EA',2); 

%Computation of ASI in each class of Coalescent embedding
[index1, group_index1, pvalue1] = compute_angular_separation(A1(:,1), C_top);
[index2, group_index2, pvalue2] = compute_angular_separation(A2(:,1), C_top);
[index3, group_index3, pvalue3] = compute_angular_separation(A3(:,1), C_top);
[index4, group_index4, pvalue4] = compute_angular_separation(A4(:,1), C_top);
[index5, group_index5, pvalue5] = compute_angular_separation(A5(:,1), C_top);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Similarily one can calculate ASI for each year dataset 
% This analysis can be repeated for the PMFG network also
