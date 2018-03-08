function [endpoint] = reflectLoc(pointstart, plane)
% Reflects a point off of a plane.
% pointstart is N x 3
% plane is N x 4

% finished switching to vector
vector = [plane(:,1), plane(:,2), plane(:,3)];
coefficient = interCoefficient(pointstart, vector, plane);
endpoint = pointstart + 2 * coefficient .* vector;
end

