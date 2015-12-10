function [sim_ac,sim_c] = sim_mat_ac(U,sim_p,w)
%Adjusted Cosine Similarity Matrix - Summary of this function goes here
% Imput R is the Rating Matrix from Users
% Output sim_ac is the Adjusted Cosine
% similarity matrix

%%Pearson correlation-based similarity%%
m = size(U,2); %2 users
% R = Y;
% w = c;


meanU = mean(U,2);

for k = 1:size(U,2)
    for l = 1:size(U,2)
        num = 0;
        den_1 = 0;
        den_2 = 0;
        for u = 1:size(U,1)
            num = num + (U(u,k) - meanU(u))*(U(u,l) - meanU(u));
            den_1 = den_1 + (U(u,k) - meanU(u))^2;
            den_2 = den_2 + (U(u,l) - meanU(u))^2;
        end
%         num = sum((U(:,k)'*G - R_u).*(U(:,l)'*G - R_u));
%         den_1 = sum((U(:,k)'*G - R_u).^2);
%         den_2 = sum((U(:,l)'*G - R_u).^2);
%         for u = 1:m
%             num = num+(U(:,k)'*G(:,u) - R_u(u))*(U(:,l)'*G(:,u) - R_u(u));
%             den_1 = den_1 + (U(:,k)'*G(:,u) - R_u(u)).*2;
%             den_2 = den_2 + (U(:,l)'*G(:,u) - R_u(u)).*2;
%         end
        sim_c(k,l) = (num)/(sqrt(den_1).*sqrt(den_2));
    end
    disp(['k = ',num2str(k)])
end

sim_ac = sim_p*(1-w) + sim_c*w;

end

