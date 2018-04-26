function [newLocation, interPlanes, interAngles, newDirection] = step(location, direction, length, boxSize, planes, escaped) %#ok<*INUSD>
% Input: location of a photon, step length L
% The photon travels a distance L in a random direction
% Outputs the new location of the photon

% location is a m x 3 matrix showing the Cartesian locations of the photons
% that still have to step
% direction is a m x 3 matrix showing the direction of each photon that has
% to step
% length (will eventually) be a m x 3 matrix showing the speed of each
% photon
% size is a 1 x 3 vector showing the size of the LSC
% planes is a 6 x 4 matrix showing the equations of the walls of the LSC
% escaped is a n x 1 boolean vector for which indices not to use

% disp(size(location(:,1)))
% disp(size(direction(:,1)))
% finished switching to vector

tempLocation = [location(:,1) + direction(:,1) * length, ...
               location(:,2) + direction(:,2) * length, ...
               location(:,3) + direction(:,3) * length];

tempDirection = direction;
% disp("tempLocation: " + tempLocation)
% disp("tempDirection: " + tempDirection)
% figure out everything below this point

% A and B are both N x 1 vectors
A = all(tempLocation - boxSize < 0, 2);
B = all(tempLocation > 0, 2);
% indexes of vals to change
toChange = A .* B;
toChange = ~logical(toChange);
% not sure about how to do this
loc2Change = tempLocation(toChange, :);
dir2Change = tempDirection(toChange, :);

interPlanes = 10000 .* ones(size(tempLocation,1),6); % might have to check other dimension
interAngles = 10000 .* ones(size(tempLocation,1),6);
%disp("test")
toPlanes = 10000 .* ones(size(loc2Change,1),6);

% dunno how to remove this loop
n = 1;
for k = 1:6
    changePlane = transpose(repmat(planes(:,k),1,size(loc2Change,1)));
    coeff = interCoefficient(loc2Change, -dir2Change, changePlane);
    toPlanes(coeff > 0, n) = k;
    toPlanes(coeff > length, n) = 10000;
    n = n + 1;
end
toPlanes = sort(toPlanes,2);
interPlanes(toChange,:) = toPlanes;
% below this line is unfinished
% right now interPlanes is full of smaller numbers and 10000s
%disp("interPlanes: " + interPlanes)
for a = 1:3 % if needed, change to size(interPlanes, 2)
    % should create an array of tempPlanes
    tempIndex = interPlanes(:,a) ~= 10000;
    
    if(any(tempIndex))
        tempPlane = transpose(planes(:,interPlanes(tempIndex,a))); % careful
        % disp("tempPlane: " + tempPlane)
        % disp("tempLoc: " + tempLocation(tempIndex))
        % disp("sizeInterAngles: " + size(interAngles))
        % disp("sizetempIndex: " + size(tempIndex))
        % disp("sizetempDirection: " + size(tempDirection))
        tempLocation(tempIndex,:) = reflectLoc(tempLocation(tempIndex,:), tempPlane);
        interAngles(tempIndex,a) = interangle(tempDirection(tempIndex,:), tempPlane);
        % have to reset the direction
        tempDirection(tempIndex,:) = reflectVect(tempDirection(tempIndex,:), tempPlane);
    end
end

newLocation = tempLocation;
newDirection = tempDirection;

end

