function [y1,y2]=MyFun(x1,x2)
% input argument x1 and x2 are not used in this example
a = zeros(6,1);
n = 0;
for k = 1:numel(a)
    disp(a(k))
    disp(n)
    n = n + 1;
end

end