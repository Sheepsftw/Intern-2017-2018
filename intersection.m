function [pointend] = intersection(pointstart, vector, plane)
%   Finds the intersection between a plane and a line.
%   Also finds the angle at which they meet (relative to normal)

%   finished switching to vector
t = interCoefficient(pointstart, vector, plane);

x = pointstart(:,1) + vector(:,1) .* t;
y = pointstart(:,2) + vector(:,2) .* t;
z = pointstart(:,3) + vector(:,3) .* t;
pointend = [x,y,z];
end

