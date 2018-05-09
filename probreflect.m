function [probability] = probreflect(index1, index2, iangle)
% Gives the probability that a photon will reflect
tval = sin(iangle) * index1 / index2;
probability = zeros(length(iangle),1);
probability(tval > 1) = 1;
x = (tval > 1) + (tval == 0);
x = ~logical(x);
bangle = iangle(x);
% finished switching to vectors
tangle = asin(tval(x));
refs = ((index1*cos(bangle) - index2*cos(tangle))./(index1*cos(bangle)+index2*cos(tangle))).^2;
refp = ((index1*cos(tangle) - index2*cos(bangle))./(index1*cos(tangle)+index2*cos(bangle))).^2;
refe = 0.5 * (refs + refp);
probability(x) = refe;
end

