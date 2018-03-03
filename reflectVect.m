function [endvector] = reflectVect(vector,plane)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
normal = [plane(1), plane(2), plane(3)];
projection = normal * dot(normal, vector)/magnitude(normal);
endvector = vector - 2 * projection;
end

