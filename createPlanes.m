function [planes] = createPlanes(sizes)
% creates an array of vectors [A,B,C,D], 
% which represent a plane Ax + By + Cz + D = 0.
planes = zeros(4,6);
planes(:,1) = [1,0,0,0];
planes(:,2) = [0,1,0,0];
planes(:,3) = [0,0,1,0];
planes(:,4) = [1,0,0,-sizes(1)];
planes(:,5) = [0,1,0,-sizes(2)];
planes(:,6) = [0,0,1,-sizes(3)];
end

