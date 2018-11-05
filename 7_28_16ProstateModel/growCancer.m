function [newPop, newPorp, newAvgStrat] = growCancer(pop, r, currK_max, coeff, doceLevel, avgStrat, o)
%growCancer(population, r, k, coeff)   Calculates and returns new 
%population of cancer cells, using the G function.
%Vectorized verion

s = 0.05; %0.1;

porp = pop./sum(pop);
E = coeff * porp';      %Calculates values of E, is 3x1
x = sum(pop);
findK = @(v)(currK_max.*exp(-(v.*v)/(2*o)));

G = calcG(r, x, E, findK(avgStrat), doceLevel, avgStrat);

%Calculate dUdt
dGdv = (calcG(r, x, E, findK(avgStrat+0.001), doceLevel, avgStrat+0.001) ...
    - calcG(r, x, E, findK(avgStrat-0.001), doceLevel, avgStrat-0.001))/0.002;

newAvgStrat = min(avgStrat + s*dGdv, 1);

%Old Adjust G based on drug level
%G(3) = doceCalcTemp(doceLevel, G(3));

%Unvectorized Version
% E = [0 0 0];
% G = [0 0 0];
% porp = pop./sum(pop);
% for i = 1:1:3
% 
%     E(i) = coeff(i,:) * porp';
% 
%     G(i) = r(i) * (k(i) - (1-E(i)) * sum(pop))/k(i);
% 
% end


%Stop G from being insane?
if (any(G == -inf))
    G(G==-inf) = -1;
    disp('G was -inf')
end

newPop = pop + pop .* G; %Find new populations

%keep all pops alive???
if(any(newPop<0.1))
    newPop(newPop<0.1) = 0.1;
    disp('Pop Saved')
end

newPorp = newPop./sum(newPop); %Calculate new porportion


end


