%% Soumyanil Banerjee

function P = collab_predict(S,R,Rtrain,n,u,k,centers,genres,U)
% S=similarity matrix for items (nxn)
% R=Ratings matrix with rows for users and cols for items (mxn)
% n=number of neighbors to look at
% the nearest n neighbors are those that are most similar to item i
% u=id's of users of interest
% k=id's of items of interest
% P=prediction of rating by users u for items k
% R = Ytrain;
% Rtrain = R;
[r,~] = size(Rtrain);
meanR = Rtrain;
meanR(meanR==0) = NaN;
meanR = nanmean(meanR,2);
P = zeros(length(k),length(u));
meanU = mean(U,2);
for i=1:length(u)
    for j=1:length(k)
        if k(j)<=r %check to make sure it's not a new item
            [sim,ind] = sort(S(:,k(j)),'descend'); %generate vector of similarities 
                                                    %for item k in descending order for items u(i) has rated
            num = 0;
            den = 0;
            for a = 1:n
                if R(ind(a+1),u(i))>0
                    num = num + (R(ind(a+1),u(i)) - meanR(ind(a+1)))*sim(a+1);
                    den = den + abs(sim(a+1));
    %                 (R(ind(2:n+1),u(i)) - meanR(ind(2:n+1)))'*sim(2:n+1);
%                 den = sum(abs(sim(2:n+1)))
                end
            end
            %P(i,j) = meanR(k(j))+sum((R(ind(2:n+1),u(i))-meanR(ind(2:n+1))).*sim(2:n+1))...
                %/sum(abs(sim(2:n+1)));
%                 num
%                 den
%                 i
%                 j
%                 pause
            if isnan(num/den) % check to see the validity
                P(j,i) = meanR(k(j));
            else
                P(j,i) = meanR(k(j)) + num/den;
            end
            
        else
            %assign new item to cluster
            for a = 1:length(centers)
                dist(a) = norm(genres(k(j),:) - centers(a,:));
            end
            weights = dist/sum(dist);
            for l = 1:r
                num = 0;
                den_1 = 0;
                den_2 = 0;
                for a = 1:size(U,1)
                    num = num + (weights(a) - meanU(a))*(U(a,l) - meanU(a));
                    den_1 = den_1 + (weights(a) - meanU(a))^2;
                    den_2 = den_2 + (U(a,l) - meanU(a))^2;
                end
                sim_c(l) = (num)/(sqrt(den_1).*sqrt(den_2));
            end
            
            [sim,ind] = sort(sim_c,'descend');
            
            avg = Rtrain(ind(2:n+1),:);
            avg(avg == 0) = NaN;
            avg = nanmean(avg);
            P(j,i) = nanmean(avg);
            
            %generate similarity vector
            %calculate prediction using other eqn
        end
    end
    disp(['u = ',num2str(u(i))])
end

end
