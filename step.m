function [newLocation, interPlanes, interAngles, newDirection] = step(location, direction, length, size, planes) %#ok<*INUSD>
% Input: location of a photon, step length L
% The photon travels a distance L in a random direction
% Outputs the new location of the photon
newLocation = [location(1) + direction(1) * length, ...
               location(2) + direction(2) * length, ...
               location(3) + direction(3) * length];
newDirection = direction;
A = all(newLocation - size < 0);
B = all(newLocation > 0);
interPlanes = [];
interAngles = [];
% if outside box.

if(A * B == 0)
    interPlanes = zeros(1,6);
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

