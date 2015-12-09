clear all, close all
%load movies.mat
%Y = Y(1:200,1:200);P


Y = [5 3 0;
    5 2 4;
    2 5 0;
    4 2 0];
[sim_p,den] = sim_mat_p(Y);
sim_p1 = corr(Y');
%load sim_p.mat
%%
% load genres.mat
% 
% options = [2,1000,1e-8,1];
% %genres = genres(1:200,:);
% [~,U,~] = fcm(genres(:,1:end-1),30,options);
U = [.98 1 .01 .95;.0013 .0002 .95 .012];
%%
c = .4;
[S,sim_c] = sim_mat_ac(U,sim_p,c);

%%
u = [1:3];
k = [1:4];
n = 2;
P = collab_predict(S,Y,n,u,k);

%%
mean(mean(abs(P-Y)))

Y1 = Y;
Y1(Y1 == 0) = NaN;

nanmean(nanmean(abs(P-Y1)))