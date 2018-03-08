function [endvector] = reflectVect(vector,plane)
% Gives the reflection of a set of vectors over a set of plane dot-wise.
% vector is N x 3
% plane is N x 4

% fix this later
normal = [plane(:,1), plane(:,2), plane(:,3)];
mag = magnitude(normal);
normal = transpose(normal);
disp("dot: " + dot(normal, transpose(vector)))
projection = normal .* dot(normal, transpose(vector)) ./ mag;
projection = transpose(projection);
disp("projection: " + projection)
endvector = vector - 2 * projection;
end

