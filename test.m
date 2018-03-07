vector = zeros(2,3);
vector(1,:) = [1, 3, 4];
vector(2,:) = [5, 7, 2];

disp("magnitude: " + magnitude(vector))
plane = zeros(2,4);
plane(1,:) = [10, 4, 2, 9];
plane(2,:) = [6, 4, 8, 1];
angle = interangle(vector, plane);
disp("angle: " + angle)