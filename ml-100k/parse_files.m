clear all, close all
user_ratings=dlmread('u.data','\t');
fid = fopen('u.item');
movie_info=textscan(fid,'%u%s%s%s%s%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u%u','Delimiter','|');
fclose(fid);


fid = fopen('u.user');
user_info=textscan(fid,'%u%u%s%s%s','Delimiter','|');
fclose(fid);
fid = fopen('u.occupation');
jobs = textscan(fid,'%s');
jobs = jobs{1};
fclose(fid);
user_id = user_info{1};
user_age = user_info{2};
gender = user_info{3};
occ = user_info{4};

for i = 1:length(gender)
    if strcmp(gender(i),'M')
        user_gender(i,1) = 1;
    else
        user_gender(i,1) = 2;
    end
end

for i=1:length(occ)
    ind = find(strcmp(jobs,occ(i)));
    user_job(i,1) = ind;
end

%%
