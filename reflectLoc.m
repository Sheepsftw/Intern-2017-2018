function [endpoint] = reflectLoc(pointstart, plane)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
vector = [plane(1), plane(2), plane(3)];
coefficient = -(plane(1) * pointstart(1) + plane(2) * pointstart(2) + plane(3) * pointstart(3) + plane(4)) ...
              /(plane(1) * vector(1) + plane(2) * vector(2) + plane(3) * vector(3));
endpoint = pointstart + 2 * coefficient * vector;
end

