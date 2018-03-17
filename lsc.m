text = fileread('lscdat.txt');
%disp(text);

point = [1,2,3]; % put in file
vector = [4,2,3]; % put in file
plane = [6,8,2,5]; % put in file
inter = intersection(point, vector, plane);
%disp(inter)

indexair = 1; % refractive index of air, put in file
indexmed = 1.49; % refractive index of slab, put in file

iangle = interangle(vector, plane);

r = probreflect(indexair, indexmed, iangle);
%disp (1 - r * r)

tic

% size of slab: 120 x 120 x 10, step length is 1, put in file
size = [120,120,10];
planes = createPlanes(size);
stepL = size(3) / 10;
probChange = 10; % probability that a photon changes direction, put in file
n = 100000; % # of photons, put in file
% simulating the photons
locations = zeros(n,3); 
planesEscaped = zeros(1,6);
totalPaths = cell(n,1);
distTraveled = zeros(1,6);
numbScattered = zeros(1,6);


traveled = [];
scattered = 0;
% starting location is somewhere on the slab
photloc = [rand(n,1)*120,rand(n,1)*120,size(3)+rand(n,1)*stepL];
direction = [zeros(n,1),zeros(n,1), ones(n,1)] * -1;
% if true, move on to next photon
escaped = 0;
counter = 1;
while ~escaped
    % traveled = (traveled:photloc);
    % newloc: 1 x 3 vector of the new location of the photon
    % interPlanes: 1-D vector with the number of the planes that the
    % photon will intersect
    % interAngles: Angle at which the photon will intersect each plane
    % in interPlanes

    % when calculating traveled, remove the excess when entering and
    % exiting
    % try to store each photon's entire path through the LSC in a
    % 100000x1 cell, the path should be a vector with variable length
    % and width 3

    %disp("photloc: " + photloc)
    [newloc, interPlanes, interAngles, newDirection] = step(photloc, direction, stepL, size, planes, N);
    direction = newDirection;
    %disp("direction: " + direction)
    for b = 1:numel(interPlanes)
        probref = probreflect(indexmed, indexair, interAngles(b));
        %disp("interAngles(b): " + interAngles(b))
        %disp("probref: " + probref)
        %disp(1 - probref*probref)
        % if escaped
        if(rand() < (1 - probref * probref))
            escaped = 1;
            planesEscaped(interPlanes(b)) = planesEscaped(interPlanes(b)) + 1;
            totalPaths(a,1) = traveled;
            numbScattered(interPlanes(b)) = numbScattered(interPlanes(b)) + scattered;
            break;
        end
    end

    photloc = newloc;
    % totalPaths = totalPaths:photloc;
    %changing direction should work now
    %dirschange = indexes of which directions to change
    dirschange = rand(N,1)*100 > probChange;
    direction(dirschange) = calculateDirection(1,length(dirschange));
    % need to figure out a way to remove finished photons from the list
end

%{
numbScattered = numbScattered ./ planesEscaped;
disp(planesEscaped)
disp(distTraveled)
disp(numbScattered)
%}
toc

