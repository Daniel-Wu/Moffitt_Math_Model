function [newR] = calcr(abiLevel, r_max, r_min)
%calcr calculates r
%   Simply adjusts r linearly from r_max to r_min as abiLevel goes to 100

newR = [0 0 r_max(3)];    %T- is unaffected
newR([1 2]) = (r_max([1 2]) - r_min([1 2]))*(1-abiLevel/100) + r_min([1 2]);
end