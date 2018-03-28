function [newLocation, interPlanes, interAngles, newDirection] = step(location, direction, length, size, planes, N, escaped) %#ok<*INUSD>
% Input: location of a photon, step length L
% The photon travels a distance L in a random direction
% Outputs the new location of the photon

% location is a n x 3 matrix showing the Cartesian locations of n photons
% direction is a n x 3 matrix showing the direction of each photon
% length (will eventually) be a n x 3 matrix showing the speed of each
% photon
% size is a 1 x 3 vector showing the size of the LSC
% planes is a 6 x 4 matrix showing the equations of the walls of the LSC

% finished switching to vector
tempLocation = [location(escaped ~= true,1) + direction(escaped ~= true,1) * length, ...
               location(escaped ~= true,2) + direction(escaped ~= true,2) * length, ...
               location(escaped ~= true,3) + direction(escaped ~= true,3) * length];

tempDirection = direction(escaped ~= true);
% figure out everything below this point

% A and B are both N x 1 vectors
A = all(tempLocation - size < 0, 2);
B = all(tempLocation > 0, 2);
% indexes of vals to change
toChange = A .* B;
toChange = logical(toChange);
% not sure about how to do this
loc2Change = tempLocation(toChange, :);
dir2Change = tempDirection(toChange, :);
interPlanes = 10000 .* ones(N,6); % looks kind of ugl
interAngles = 10000 .* ones(N,6);
%disp("test")

% dunno how to remove this loop
for k = 1:6
    tempPlane = repmat(planes(:,k),N,1);
    coeff = interCoefficient(loc2Change, dir2Change, tempPlane);
    interPlanes(coeff > 0 && coeff < length, n) = k;
    n = n + 1;
end
interPlanes = sort(interPlanes,2);
% below this line is unfinished
% right now interPlanes is full of smaller numbers and 10000s
%disp("interPlanes: " + interPlanes)
for a = 1:3 % if needed, change to size(interPlanes, 2)
    % should create an array of tempPlanes
    tempIndex = interPlanes(:,a) ~= 10000;
    tempPlane = planes(:,interPlanes(tempIndex)); % careful
    newLocation = reflectLoc(newLocation, tempPlane);
    interAngles(a) = interangle(newDirection, tempPlane);
    % have to reset the direction
    newDirection = reflectVect(newDirection, tempPlane);
end

newLocation = location;
newLocation(escaped) = tempLocation;
newDirection = direction;
newDirection(escaped) = tempDirection;

end

