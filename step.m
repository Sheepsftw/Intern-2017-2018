function [newLocation, interPlanes, interAngles, newDirection] = step(location, direction, length, size, planes) %#ok<*INUSD>
% Input: location of a photon, step length L
% The photon travels a distance L in a random direction
% Outputs the new location of the photon

% location is a n x 3 matrix showing the Cartesian locations of n photons
% direction is a n x 3 matrix showing the direction of each photon
% length (will eventually) be a n x 3 matrix showing the speed of each
% photon
% size is a 1 x 3 vector showing the size of the LSC
% planes is a 6 x 4 matrix showing the equations of the walls of the LSC

newLocation = [location(:,1) + direction(:,1) * length, ...
               location(:,2) + direction(:,2) * length, ...
               location(:,3) + direction(:,3) * length];
newDirection = direction;
% figure out everything below this point
A = all(newLocation - size < 0);
B = all(newLocation > 0);
interPlanes = [];
interAngles = [];
% if outside box.

if(A * B == 0)
    interPlanes = zeros(n,6);
    %disp("test")
    n = 1;
    for k = 1:6
        coeff = interCoefficient(location, direction, planes(:,k));
        if(coeff > 0 && coeff < length)
            interPlanes(n) = k;
            n = n + 1;
        end
    end
    interPlanes = sort(interPlanes);
    while interPlanes(1) == 0
        interPlanes(1) = [];
        % really need to find a better way to do this
        if(isempty(interPlanes))
            break;
        end
    end
    %disp("interPlanes: " + interPlanes)
    interAngles = zeros(1,numel(interPlanes));
    for a = 1:numel(interPlanes)
        tempPlane = planes(:,interPlanes(a));
        newLocation = reflectLoc(newLocation, tempPlane);
        interAngles(a) = interangle(newDirection, tempPlane);
        % have to reset the direction
        newDirection = reflectVect(newDirection, tempPlane);
    end
end

end

