%% Soumyanil Banerjee

clear all, close all
load movies.mat
rng(0);
ind = randperm(943);
Ytrain = Y(:,ind(1:900));

%%
% Ytrain = [5 3 0;
%     5 2 4;
%     2 5 0;
%     4 2 0];
[sim_p] = sim_mat_p(Ytrain);
sim_p1 = corr(Ytrain');
%load sim_p.mat
%%
load genres.mat
%%
options = [1.1,1000,1e-8,1];
%k = [5:10:100]; % # of clusters
k = 30;
for i = 1:length(k) % iterating over different genres
    [centers,U,~] = fuzzy(genres(:,1:end-1),k(i),options);
    % U = [.98 1 .01 .95;.013 .002 .95 .12];

    c = .4;
    [S,sim_c] = sim_mat_ac(U,sim_p,c);

%     u = ind(901:end);
%     k = [1:1682];
    u = [ind(901:943)];
    mov = [1:1682];
    n = 30;
    P = collab_predict(S,Y,Ytrain,n,u,mov,centers,genres(:,1:end-1),U);
    roundP = round(2*P)/2;
    
    Y1 = Y(mov,u);
    Y1(Y1 == 0) = NaN;

    MAE(i) = nanmean(nanmean(abs(P-Y1)))
end