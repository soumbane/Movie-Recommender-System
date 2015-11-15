%% Collaborative Filtering
% Gaurav Kumar Singh
% gauravs@umich.edu
%  
clear all
close all
clc
fprintf('Loading movie ratings dataset.\n\n');

%  Load data
load ('movies.mat');
% Two matrices in Y and R - Y contains ratings, R is binary valued
%  Y is a 1682x943 matrix, containing ratings (1-5) of 1682 movies on 
%  943 users. 0 indicates no ratings. We have to fill those zeros.
%
%  R is a 1682x943 matrix, where R(i,j) = 1 if and only if user j gave a
%  rating to movie i

%  From the matrix, we can compute statistics like average rating.
% For example - Average rating for movie k = mean(Y(k, R(k, :))));

%  We can "visualize" the ratings matrix by plotting it with imagesc
imagesc(Y);
ylabel('Movies');
xlabel('Users');




%% ============== Entering ratings for a new user ===============
%  Before we will train the collaborative filtering model, we will first
%  add ratings that correspond to a new user that we just observed. 
%
movieList = loadMovieList();

%  Initialize my ratings
my_ratings = zeros(1682, 1);


fprintf('Lets figure out what do you like ... \n \n');
fprintf...
('Rate the following movies in scale of 1-5... \nIf not watched- press enter\n')
proposed_id = randperm(1682);
num_rated=0;
for i=1:length(proposed_id)
    if num_rated~=15
        rating=input(sprintf...
            ('\nRating for " %s " [1-5]?\n',movieList{proposed_id(i),1}));
        if isempty(rating)
        my_ratings(proposed_id(i))=0;
        end
        if rating>0
        my_ratings(proposed_id(i))=rating;
        num_rated=num_rated+1;
        end
    end
end

fprintf('\n\nNew user ratings:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('Rated %d for %s\n', my_ratings(i), ...
                 movieList{i});
    end
end



%% ================== Learning Movie Ratings ====================
%  Now, you will train the collaborative filtering model on a movie rating 
%  dataset of 1682 movies and 943 users
%

Y = [my_ratings Y];
R = [(my_ratings ~= 0) R];

%  Normalize Ratings
[Ynorm, Ymean] = normalizeRatings(Y, R);

%  Useful Values
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 10;

% Set Initial Parameters (Theta, X)
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

% Set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

% Set Regularization
lambda = 10;
theta = fmincg (@(t)(collab_filter_CostFunc(t, Y, R, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);

% Unfold the returned theta back into U and W
X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('Recommender system learning completed.\n');


%% ================== Recommendation for you ====================
%  After training the model, you can now make recommendations by computing
%  the predictions matrix.
%

p = X * Theta';
my_predictions = p(:,1) + Ymean;

movieList = loadMovieList();

[r, ix] = sort(my_predictions, 'descend');
fprintf('\nTop recommendations for you:\n');
for i=1:10
    j = ix(i);
    fprintf('Predicting rating %.1f for movie %s\n', my_predictions(j), ...
            movieList{j});
end

fprintf('\n\nOriginal ratings provided:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('Rated %d for %s\n', my_ratings(i), ...
                 movieList{i});
    end
end
