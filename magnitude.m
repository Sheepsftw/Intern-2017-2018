function [magnitude] = magnitude(vector)
% Calculates the magnitude of an input vector.
n = vector.*vector;
squared = sum(n);
magnitude = sqrt(squared);
end

