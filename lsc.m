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
boxSize = [120,120,10];
planes = createPlanes(boxSize);
stepL = boxSize(3) / 10;
probChange = 10; % probability that a photon changes direction, put in file
n = 100000; % # of photons, put in file
% simulating the photons
locations = zeros(n,3); 
totalPaths = cell(n,1);
distTraveled = zeros(1,6);
numbScattered = zeros(1,6);


traveled = [];
scattered = 0;
% starting location is somewhere on the slab
photloc = [rand(n,1)*120,rand(n,1)*120,boxSize(3)+rand(n,1)*stepL];
escaped = false(n,1);
escapedT = zeros(n,1);
planesEscaped = zeros(6,1);
direction = [zeros(n,1),zeros(n,1), ones(n,1)] * -1;
% if true, move on to next photon
counter = 0;
while ~all(escaped)
    % disp(sum(escaped))
    counter = counter + 1;
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
    % disp("direction: " + direction(escaped ~= true,:))
    % disp("photloc: " + photloc)
    photstep = photloc(escaped ~= true,:);
    dirstep = direction(escaped ~= true,:);
    % disp("photstep: " + photstep)
    [newloc, interPlanes, interAngles, newDirection] = step(photstep, dirstep, stepL, boxSize, planes, escaped);
    direction(escaped ~= true,:) = newDirection;
    % disp("add: " + newloc(escaped ~= true,:))
    % disp("size: " + totalPaths(escaped ~= true, counter))
    
    % totalPaths = cellfun() (do something with this)
    %disp("direction: " + direction)
    transT = zeros(length(newloc),1);
    for b = 1:3
        % make it so that interAngles is n x 3
        probref = probreflect(indexmed, indexair, interAngles(:,b));
        %disp("interAngles(b): " + interAngles(b))
        %disp("probref: " + probref)
        %disp(1 - probref*probref)
        % if escaped
        
        %pretty inefficient
        probtrans = ones(length(probref),1) - probref .* probref;
        transmitted = (rand(length(probref),1) < probtrans);
        
        % this is to add 1 to all photons that escaped this iteration
        escaped(transmitted) = true; 
        escapedT(transmitted) = counter;
        % disp("sizeEscaped: " + size(nextEscaped))
        % disp("sizeInter: " + size(interPlanes))
        % disp("sizePlanes: " + size(planesEscaped))
        % planesEscaped(interPlanes(transmitted,b)) = planesEscaped(interPlanes(transmitted,b)) + 1;
        % disp("planesEscaped: " + planesEscaped)
        
        % looks pretty inefficient to me
    end
    % disp("lastDir: " + direction(1,:))
    % disp("lastEsc: " + escaped)
    % disp("lastLoc: " + newloc(1,:))
    disp(sum(escaped))
    disp(sum(transT))
    photloc(escaped ~= true, :) = newloc(transT ~= true, :);
    % totalPaths = totalPaths:photloc;
    %changing direction should work now
    %dirschange = indexes of which directions to change
    dirschange = rand(n,1)*100 < probChange;
    % disp("sum: " + sum(dirschange))
    direction(dirschange,:) = calculateDirection(1,sum(dirschange));
    % need to figure out a way to remove finished photons from the list
end

%{
numbScattered = numbScattered ./ planesEscaped;
disp(planesEscaped)
disp(distTraveled)
disp(numbScattered)
%}
toc

