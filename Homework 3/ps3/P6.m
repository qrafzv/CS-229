% CS 229 Homework 3 Problem 6 %
close all; clear all; clc;

% (a) %
A = double(imread('mandrill-large.tiff'));
figure;
imshow(uint8(round(A)));


% (b) %
iters = 50;

A = double(imread('mandrill-small.tiff'));

% Format A into pixel vectors %
c = [];
for i = 1:3, b{i} = A(:,:,i); c = [c b{i}(:)]; end;
c = c';
n = size(c,2);

% Initialization step %
rand('seed',0); 
k = 16;
m = zeros(3,k);
rnums = randperm(n);
rnums = rnums(1:k);         % Choose k random points %

for i = 1:16,
    m(:,i) = c(:,rnums(i));
end

% Calculation / Update step %
for iter = 1:iters,
    % Classify each pixel %
    y = zeros(n,1);
    for j = 1:n,
        x = c(:,j)*ones(1,k);
        [~,y(j)] = min(norms(x-m));
    end
    % update centroids %
    for i = 1:k,
        m(:,i) = mean(c(:,y==i),2);
    end
end

% (c) %
A = double(imread('mandrill-large.tiff'));
for i = 1:size(A,1),
    for j = 1:size(A,2),
        a = A(i,j,:);   % Grab pixel (i,j) %
        a = a(:);       % pixels colors need to be vectorized %
        
        [~,ind] = min(norms(a*ones(1,k)-m));
        A(i,j,:) = m(:,ind);
    end 
end
figure;
imshow(uint8(round(A)));