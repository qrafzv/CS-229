% nb_test.m %

[spmatrix, tokenlist, category] = readMatrix('MATRIX.TEST');

testMatrix = full(spmatrix);
numTestDocs = size(testMatrix, 1);
numTokens = size(testMatrix, 2);

output = zeros(numTestDocs, 1);

%---------------
% YOUR CODE HERE

log_likelihood_given_0 = testMatrix*logphi0' + log(p0);
log_likelihood_given_1 = testMatrix*logphi1' + log(p1);

output = log_likelihood_given_1 > log_likelihood_given_0;
%---------------


% Compute the error on the test set
error=0;
for i=1:numTestDocs
  if (category(i) ~= output(i))
    error=error+1;
  end
end

%Print out the classification error on the test set
error/numTestDocs