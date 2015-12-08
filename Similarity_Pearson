function [sim_p,den] = sim_mat_p(R)
%Pearson Similarity Matrix - Summary of this function goes here
% Imput R is the Rating Matrix from Users
% Output sim_p is the Pearson similarity matrix

%%Pearson correlation-based similarity%%
% R = Y;
m = size(R,1); %2 users
sim_p = zeros(m); %10 movies
% sim_c = zeros(size(R,2));

% rating_user1 = [3,4,5,3,4,5,5,4,5,3];
% rating_user2 = [2,4,3,4,4,4,5,5,5,3];
% R = [rating_user1;rating_user2];

% R_k = mean(R,2);
meanR = R;
meanR(meanR==0) = NaN;
R_k = nanmean(meanR,2);


% R_u = (mean(R'))';

% for i=1:m
%     R_k(i) = mean([rating_user1(i),rating_user2(i)]);
%     
% end

num = zeros(m);
den = zeros(m);
for k=1:size(sim_p,1)
    for l=1:size(sim_p,2)
        num(k,l) = (R(k,:)-R_k(k))*(R(l,:)-R_k(l))';
        den(k,l) = sqrt((R(k,:)-R_k(k))*(R(k,:)-R_k(k))')*sqrt( (R(l,:) - R_k(l))*(R(l,:) - R_k(l))');
        
        sim_p(k,l) = num(k,l)/den(k,l);
    end
    disp(['k = ',num2str(k)])
end


end

