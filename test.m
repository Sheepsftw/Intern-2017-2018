
x = [-0.60, 59.65, 10.09];
v = [0.72, -0.44, -0.54];
planes = createPlanes([120,120,10]);
planes = transpose(planes);
disp(interCoefficient(x,v,planes(1,:)))
disp(interCoefficient(x,v,planes(2,:)))
disp(interCoefficient(x,v,planes(3,:)))
disp(interCoefficient(x,v,planes(4,:)))
disp(interCoefficient(x,v,planes(5,:)))
disp(interCoefficient(x,v,planes(6,:)))