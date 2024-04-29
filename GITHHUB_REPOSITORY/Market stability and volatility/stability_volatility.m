load('Results_data(26_05_23).mat') %load dataset
 
Year18 =194:376; 
data_year_2018 = data(Year18,:); % extraction of data corresponding to year 2018

for itr=1:124
T = data_year_2018(itr:itr+60-1,:);  % construction of MST with window size 60 days and 1 day as rolling 
[C P]=corrcoef(T); 
Ad = sqrt(2*(1-C));
G1=graph(Ad,'upper');
[T1, pred]=minspantree(G1,'Method','dense');
B1 = full(adjacency(T1));
Ad(find(~B1))=0;
C(find(~B1))=0;

Gx = graph(C,'upper');
EW_YEAR_2018(itr) = mean(Gx.Edges.Weight);  %Average edge weight

Gy = graph(Ad,'upper');
M2 = distances(Gy);      
SD_YEAR_2018(itr) = sum(M2(:))/(383*382);  %Average shortest path distance

%%%%%%%%%%%%%%  EMBEDDING OF THE MST IN POINCARE DISC VIA MANY CLASSES OF
%%%%%%%%%%%%%%  CAOLESCENT EMBEDDING FOR EXAMPLE ISOMAP(ISO-CA) 
A = coalescent_embedding(Ad,'original','ISO','original',2); 
dist  =zeros(length(T),length(T));
for i = 1:length(T)
for j = 1:length(T)
dist(i,j) = hyperbolic_dist_2D(A(i,1:2), A(j,1:2));
end
end
HD_YEAR_2018(itr) = sum(dist(:))/(383*382);
dist(find(~Ad))=0;
Gz = graph(dist,'upper');
R  = distances(Gz);
HSD_YEAR_2018(itr) =  sum(R(:))/(383*382);
end
clear C Ad Gx Gy Gz R
%%%%%%%%%%%%%%%%%%%%%%%%
load('Results_data(26_05_23).mat') 

Year2020 =556:751; 
data_year_2020 = data(Year2020,:); % extraction of data corresponding to year 2020

for itr=1:137
T = data_year_2020(itr:itr+60-1,:); 
[C P]=corrcoef(T); 
Ad = sqrt(2*(1-C));
G1=graph(Ad,'upper');
[T1, pred]=minspantree(G1,'Method','dense');
B1 = full(adjacency(T1));
Ad(find(~B1))=0;
C(find(~B1))=0;
Gx = graph(C,'upper');
EW_YEAR_2020(itr) = mean(Gx.Edges.Weight); %Average edge weight

Gy = graph(Ad,'upper');
R = distances(Gy);
SD_YEAR_2020(itr) = sum(R(:))/(383*382); %Average shortest path distance
%%%%%%%%%%%%%%
%%%%%%%%%%%%%%  EMBEDDING OF THE MST IN POINCARE DISC VIA MANY CLASSES OF
%%%%%%%%%%%%%%  CAOLESCENT EMBEDDING FOR EXAMPLE ISOMAP(ISO-CA) 
A = coalescent_embedding(Ad,'original','ISO','original',2); 
dist = zeros(length(T),length(T));

for i = 1:length(T)
for j = 1:length(T)
dist(i,j)  = hyperbolic_dist_2D(A(i,1:2), A(j,1:2));

end
end
HD_YEAR_2020(itr) = sum(dist(:))/(383*382);
dist(find(~Ad))=0;
Gz = graph(dist,'upper');
R  = distances(Gz);
HSD_YEAR_2020(itr) =  sum(R(:))/(383*382);
end

MW_TOPO_P_VALUES = [mwwtest(EW_YEAR_2018,EW_YEAR_2020).p; mwwtest(SD_YEAR_2018,SD_YEAR_2020).p];
MW_GM_P_VALUES = [mwwtest(HD_YEAR_2018,HD_YEAR_2020).p; mwwtest(HSD_YEAR_2018,HSD_YEAR_2020).p];
MEAN_TOPO_MEASURE_2018 = [mean(EW_YEAR_2018);mean(SD_YEAR_2018)];
MEAN_TOPO_MEASURE_2020 = [mean(EW_YEAR_2020);mean(SD_YEAR_2020)];
MEAN_GM_MEASURE_2018 = [mean(HD_YEAR_2018);mean(HSD_YEAR_2018)];
MEAN_GM_MEASURE_2020 = [mean(HD_YEAR_2020);mean(HSD_YEAR_2020)];
% Similarily this code can be performed for other classes of coalecent embedding algorithms 
% just change the class name via ("ncISO", "LE","MCE","ncMCE") and angular adjustment
% ("original","EA")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% One can repeat the Same analysis for the PMFG network by replacing this commands
%G1=graph(Ad,'upper');
%[T1, pred]=minspantree(G1,'Method','dense');
%B1 = full(adjacency(T1));
%Ad(find(~B1))=0;
%C(find(~B1))=0;
%with this below commands in both year codes 
%PM = pmfg(C);  % For this PMFG function matlab has published library as: ("https://in.mathworks.com/matlabcentral/fileexchange/38689-pmfg")
%Ad(find(~PM))=0;
%Gx = graph(PM,'upper');
