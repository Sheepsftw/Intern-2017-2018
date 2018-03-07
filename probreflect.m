function [probability] = probreflect(index1, index2, iangle)
% Gives the probability that a photon will reflect
tval = sin(iangle) * index1 / index2;
% disp("tval: " + tval)
% should work for scalars right now, though maybe vectors?
if(tval > 1)
    probability = 1;
elseif(tval == 0)
    probability = 0;
else
    tangle = asin(tval);
    % disp("tangle: " + tangle)
    probability = -sin(iangle - tangle) / sin(iangle + tangle);
end

end

