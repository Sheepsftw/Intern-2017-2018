vector = zeros(2,3);
vector(1,:) = [1, 3, 4];
vector(2,:) = [5, 7, 2];

vect = [true, false, true];
vect2 = [true, true, false];
vect = vect .* vect2;
val = [-1, 2, 1];
val(logical(vect)) = 5;
disp("changed: " + val)

% disp("magnitude: " + magnitude(vector))
plane = zeros(2,4);
plane(1,:) = [10, 4, 2, 9];
plane(2,:) = [6, 4, 8, 1];
angle = interangle(vector, plane);
% disp("angle: " + angle)

point = zeros(2,3);
point(1,:) = [0, 0, 0];
point(2,:) = [1, 9, -1];

iangle = interangle(vector, plane);
disp("probreflect: " + probreflect(1, 1.49, iangle));