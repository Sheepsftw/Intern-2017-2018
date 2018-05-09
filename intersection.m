function [pointend] = intersection(pointstart, vector, plane)
%   Finds the intersection between a plane and a line.
%   Also finds the angle at which they meet (relative to normal)

%   finished switching to vector
t = interCoefficient(pointstart, vector, plane);
newvect = vector ./ magnitude(vector);

x = pointstart(:,1) + newvect(:,1) .* t;
y = pointstart(:,2) + newvect(:,2) .* t;
z = pointstart(:,3) + newvect(:,3) .* t;
pointend = [x,y,z];
end

