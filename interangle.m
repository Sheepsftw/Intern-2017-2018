function [angle] = interangle(vector, plane)
%UNTITLED5 Summary of this function goes here
%   vector should be N x 3
%   plane should be N x 4
% unfinished
norm = [plane(:,1), plane(:,2), plane(:,3)];
norm = transpose(norm);
vector = transpose(vector);
% disp("dot: " + dot(norm, vector));
% fix the next line
cosval = abs(dot(norm, vector) ./ (magnitude(norm) .* magnitude(vector)));
% disp("cosval: " + cosval)
angle = acos(cosval);
% disp("angle: " + angle)
end

