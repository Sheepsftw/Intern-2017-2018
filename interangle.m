function [angle] = interangle(vector, plane)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
norm = [plane(1), plane(2), plane(3)];
cosval = abs(dot(norm, vector)/(magnitude(norm) * magnitude(vector)));
%disp("cosval: " + cosval)
angle = acos(cosval);
%disp("angle: " + angle)
end

