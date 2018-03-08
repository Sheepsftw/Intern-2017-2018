function [coefficient] = interCoefficient(pointstart, vector, plane)
%UNTITLED Summary of this function goes here
%   pointstart is N x 3
%   vector is N x 3
%   plane is N x 4
%   finished switching to vector

% disp("plane: " + plane(:,1))
% disp("vector: " + vector(:,1))
    
coefficient = -(plane(:,1) .* pointstart(:,1) + plane(:,2) .* pointstart(:,2) + plane(:,3) .* pointstart(:,3) + plane(:,4)) ...
                  ./(plane(:,1) .* vector(:,1) + plane(:,2) .* vector(:,2) + plane(:,3) .* vector(:,3));
numRows = size(plane);
for n = 1:numRows(1)
    if(plane(n,1) * vector(n,1) + plane(n,2) * vector(n,2) + plane(n,3) * vector(n,3) == 0)
        coefficient(n) = 10000;
    end
end

