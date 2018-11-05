function [G] = calcG(r, x, E, k, doceLevel, avgStrat)
%calcG Calculates and returns G

G = r.*(1 - x*(1-E')./k);

%New: calculate Mu
alpha = 4;
b = 4;%10;
deadliness = alpha.*(1-G);   %Linear assumption for D.
mu = doceLevel./(deadliness + b.*avgStrat);


G = G - mu;

end

