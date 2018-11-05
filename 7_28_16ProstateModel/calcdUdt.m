function [dUdt] = calcdUdt(pop, avgStrat, k_max, growthRate, drugLevel, E, o, b, a)
%calcdUdt returns dU/dt
%   Uses the linear assumption for D, and returns the rate of change of the
%   average strategy of drug resistance with the given variables.
%   Var documentation:
%   x = total population
%   v = strategy, from 0 to 1
%   o = (measure of cost of strategy)^2
%   k = k_max
%   b = effectiveness modifier on strategy
%   a = coefficient for G's impact on drug effectiveness
%   s = evolution rate coefficient
%   r = population net growth rate
%   m = drug concentration*some constant
%   E = benefit matrix
%   

%Define the vars

x = sum(pop);
dUdt = [0 0 0];
s = 0.0000002;
m = drugLevel * 1;
    
for cellType = 1:3

    K = k_max(cellType);
    v = avgStrat(cellType);
    r = growthRate(cellType);
    longTerm = (1-E(cellType)).*x.*exp((v.^2)./(2.*o))./K;

    numerator = m.*(b + a.*r.*v.*longTerm./o);
    denom = (b.*v - a.*r.*(1 - longTerm)).^2;

    dGdV = numerator./denom - r.*v.*longTerm./o;

    dUdt(cellType) = s*dGdV;

end

end

