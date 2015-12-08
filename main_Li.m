clear all, close all
load movies.mat
Y = Y(1:100,1:100);
[sim_p,den] = sim_mat_p(Y);

%%
load genres.mat

genres = genres(1:100,:);
[~,U,~] = fcm(genres(:,1:end-1),10);

%%
c = .4;
[S,sim_c] = sim_mat_ac(U,sim_p,c);

%%
u = [1:10];
k = [1:10];
n = 5;
P = collab_predict(S,Y,n,u,k);