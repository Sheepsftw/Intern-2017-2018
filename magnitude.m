function [magnitude] = magnitude(vector)
% Calculates the magnitude of an input vector.
% vector should be N x 3
% switched to vector
n = vector.*vector;
squared = sum(transpose(n));
magnitude = sqrt(squared);
magnitude = transpose(magnitude);
end

