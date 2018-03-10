function [angle] = interangle(vector, plane)
%UNTITLED5 Summary of this function goes here
%   vector should be N x 3
%   plane should be N x 4
% finished switching to vector
norm = [plane(:,1), plane(:,2), plane(:,3)];
% disp("magnitude: " + magnitude(norm))
% disp("dot: " + dot(transpose(norm), transpose(vector)));
% i really should have fixed the vector order earlier, now there's so many
% transposes :/
cosval = abs(transpose(dot(transpose(norm), transpose(vector))) ./ (magnitude(norm) .* magnitude(vector)));
% disp("cosval: " + cosval)
angle = acos(cosval);
% disp("angle: " + angle)
end

