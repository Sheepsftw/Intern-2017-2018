vals = photontrace{1,1};
a = vals(1);
c = vals(2);
w = vals(3);
stepL = c/10;
planes = createPlanes([a a c]);
planesEscaped = zeros(1,6);

photlocs = photontrace{1,2};
for n = 1:length(photlocs)
    path = photlocs{n};
    point1 = path(size(path, 1), :);
    point2 = path(size(path,1) - 1, :);
    dir = point1 - point2;
    if(n == 15366)
       %disp(dir) 
    end
    %dist = sqrt(dir(1) * dir(1) + dir(2) * dir(2) + dir(3) * dir(3));
    %disp(dist)
    for m = 1:6
        coeff = interCoefficient(point1, -dir, transpose(planes(:,m)));
        %disp(coeff)
        if(coeff > 0 && coeff < stepL)
            planesEscaped(m) = planesEscaped(m) + 1;
            break;
        end
    end
end

%disp(stepL)
disp("plane1: " + planesEscaped(1))
disp("plane2: " + planesEscaped(2))
disp("plane3: " + planesEscaped(3))
disp("plane4: " + planesEscaped(4))
disp("plane5: " + planesEscaped(5))
disp("plane6: " + planesEscaped(6))