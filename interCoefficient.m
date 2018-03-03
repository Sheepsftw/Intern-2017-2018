function [coefficient] = interCoefficient(pointstart, vector, plane)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if(plane(1) * vector(1) + plane(2) * vector(2) + plane(3) * vector(3) == 0)
    coefficient = 10000;
else
    coefficient = -(plane(1) * pointstart(1) + plane(2) * pointstart(2) + plane(3) * pointstart(3) + plane(4)) ...
                  /(plane(1) * vector(1) + plane(2) * vector(2) + plane(3) * vector(3));
end

