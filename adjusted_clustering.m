clear
close
clc
%% Load Data
load 'genres.mat'
load 'user.mat'
num_genres=10;
num_users=10;
%% CLustering
opts=statset('Display','final');
[idx_genre,C_genre]=kmeans(genres,num_genres,'Distance','cityblock',...
    'Replicates',10,'Options',opts);
[idx_user,C_user]=kmeans(user,num_users,'Distance','cityblock',...
    'Replicates',10,'Options',opts);
w=zeros(1682,10);
%% m parameter
m=1.1;
distance=zeros(10,1682);
for i=1:num_genres
    for j=1:size(genres,1)
        distance(i,j)=norm(C_genre(i,:)-genres(j,:));
    end
end
num=distance.^(-2/(m-1));
num=num';
den=sum(num,2);
membership=zeros(1682,num_genres);
for a=1:1682
    membership(a,:)=num(a,:)/den(a);
end
membership(isnan(membership))=1;

