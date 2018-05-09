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
aa=3.9201;
cc=0.2432;
ww=347.9773;

boxSize = [aa,aa,cc];
%boxSize = [120,120,10];
planes = createPlanes(boxSize);
stepL = boxSize(3) / 10;
probChange = 100 * (1 - 10^(-ww*stepL*0.03188)); % probability that a photon changes direction, put in file
%probChange = 100;
n = floor(aa * aa * 1000); % # of photons, put in file
% simulating the photons
locations = zeros(n,3); 
totalPaths = cell(n,1);
distTraveled = zeros(1,6);
numbScattered = zeros(1,6);


traveled = [];
scattered = zeros(n,1);
% starting location is somewhere on the slab
photloc = [rand(n,1)*boxSize(1),rand(n,1)*boxSize(2), boxSize(3)+stepL*rand(n,1)];
%photloc = [rand(n,1)*boxSize(1),rand(n,1)*boxSize(2), boxSize(3)+(ones(n,1)*stepL*0.5)];
escaped = false(n,1);
escapedT = zeros(n,1);
planesEscaped = zeros(6,1);
direction = [zeros(n,1),zeros(n,1), ones(n,1)] * -1;
% if true, move on to next photon
counter = 0;
cellGather6 = 0;
while ~all(escaped)
    %disp(sum(escaped))
    %disp(find(~escaped))
    %if(sum(escaped) > 99990)
    %    disp(find(~escaped))
    %end
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
    % disp("photstep: " + photstep)
    [newloc, interPlanes, interAngles, newDirection] = step(photloc, direction, stepL, boxSize, planes, escaped);
    direction = newDirection;
    % disp("add: " + newloc(escaped ~= true,:))
    % disp("size: " + totalPaths(escaped ~= true, counter))
    
    % totalPaths = cellfun() (do something with this)
    %disp("direction: " + direction)
    for b = 1:3
        % make it so that interAngles is n x 3
        probref = probreflect(indexmed, indexair, interAngles(:,b));
        %disp("interAngles(b): " + interAngles(b))
        %disp("probref: " + probref)
        %disp(1 - probref*probref)
        % if escaped
        
        %pretty inefficient
        probtrans = ones(length(probref),1) - probref;%.* probref;
        transmitted = (rand(length(probref),1) < probtrans);
        cellGather1 = interPlanes(:,b) == 1;
        cellGather2 = interPlanes(:,b) == 2;
        cellGather3 = interPlanes(:,b) == 4;
        cellGather4 = interPlanes(:,b) == 5;
        tempGather6 = interPlanes(:,b) == 6;
        cellGather6 = cellGather6 + nnz(transmitted .* tempGather6);
        transmitted = transmitted + cellGather1 + cellGather2 + cellGather3 + cellGather4;
        tempmul = ~escaped .* transmitted;
        %tempmul = tempmul + cellGather1 + cellGather2 + cellGather3 + cellGather4;
        
        % this is to add 1 to all photons that escaped this iteration
        escapedT(logical(tempmul)) = counter;
        escaped(logical(transmitted)) = true; 
        % disp("sizeEscaped: " + size(nextEscaped))
        % disp("sizeInter: " + size(interPlanes))
        % disp("sizePlanes: " + size(planesEscaped))
        planesEscaped(logical(tempmul)) = interPlanes(logical(tempmul),b);
        % disp("planesEscaped: " + planesEscaped)
        
        % looks pretty inefficient to me
    end
    % disp("lastDir: " + direction(1,:))
    % disp("lastEsc: " + escaped)
    % disp("lastLoc: " + newloc(1,:)
    up1 = nnz(direction(:,3) >= 0);
    up = nnz((direction(:,3) >= 0) .* (direction(:,3) <= 0.5));
    totalPaths{counter, 1} = histcounts(planesEscaped, [1 2 3 4 5 6]);
    totalPaths{counter, 2} = photloc;
    photloc = newloc;
    
    %changing direction should work now
    %dirschange = indexes of which directions to change
    dirschange = rand(n,1)*100 < probChange;
    % disp("sum: " + sum(dirschange))
    direction(dirschange,:) = calculateDirection(1,sum(dirschange));
    % need to figure out a way to remove finished photons from the list
end
disp("cellGather6: " + cellGather6);

pEscaped = zeros(1,6);
pEscaped(1) = nnz(planesEscaped == 1);
pEscaped(2) = nnz(planesEscaped == 2);
pEscaped(3) = nnz(planesEscaped == 3);
pEscaped(4) = nnz(planesEscaped == 4);
pEscaped(5) = nnz(planesEscaped == 5);
pEscaped(6) = nnz(planesEscaped == 6);

pp = sum(planesEscaped == 1) + sum(planesEscaped == 2) + sum(planesEscaped == 4) + sum(planesEscaped == 5);
% disp("P: " + pp / n)
disp("plane1: " + pEscaped(1))
disp("plane2: " + pEscaped(2))
disp("plane3: " + pEscaped(3))
disp("plane4: " + pEscaped(4))
disp("plane5: " + pEscaped(5))
disp("plane6: " + pEscaped(6))
%{
numbScattered = numbScattered ./ planesEscaped;
disp(planesEscaped)
disp(distTraveled)
disp(numbScattered)
%}
toc

