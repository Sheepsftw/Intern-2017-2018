function [newDirection] = calculateDirection(radius, N)
% Randomly generates a Cartesian vector uniformly on a sphere
%  radius = length of vector to generate
%  N = number of vectors to generate

% finished switchching to vector
phi = 2*pi*rand(N,1);
theta = acos(2*rand(N,1)-1);
newDirection = zeros(N,3);
newDirection(:,1) = radius.*sin(theta).*cos(phi);
newDirection(:,2) = radius.*sin(theta).*sin(phi);
newDirection(:,3) = radius.*cos(theta);
end

