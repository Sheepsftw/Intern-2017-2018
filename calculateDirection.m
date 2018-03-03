function [newDirection] = calculateDirection(radius)
% Randomly generates a Cartesian vector uniformly on a sphere
% with radius as parameter.
phi = 2*pi*rand();
theta = acos(2*rand()-1);
newDirection = zeros(1,3);
newDirection(1,1) = radius*sin(theta)*cos(phi);
newDirection(1,2) = radius*sin(theta)*sin(phi);
newDirection(1,3) = radius*cos(theta);
end

