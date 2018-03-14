function [magnitude] = magnitude(vector)
% Calculates the magnitude of an input vector.
% vector should be N x 3
% finished switching to vector
n = vector.*vector;
squared = sum(n,2);
magnitude = sqrt(squared);
end

