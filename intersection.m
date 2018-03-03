function [pointend] = intersection(pointstart, vector, plane)
%   Finds the intersection between a plane and a line.
%   Also finds the angle at which they meet (relative to normal)
t = -(plane(1) * pointstart(1) + plane(2) * pointstart(2) + plane(3) * pointstart(3) + plane(4)) ...
    /(plane(1) * vector(1) + plane(2) * vector(2) + plane(3) * vector(3));

x = pointstart(1) + vector(1) * t;
y = pointstart(2) + vector(2) * t;
z = pointstart(3) + vector(3) * t;
pointend = [x,y,z];
end

