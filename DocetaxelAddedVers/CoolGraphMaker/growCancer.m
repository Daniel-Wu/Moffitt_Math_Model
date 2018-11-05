function [newPop, newPorp, newAvgStrat] = growCancer(pop, r, k, currK_max, coeff, doceLevel, avgStrat, o)
%growCancer(population, r, k, coeff)   Calculates and returns new 
%population of cancer cells, using the G function.
%Vectorized verion.
porp = pop./sum(pop);
E = coeff * porp';      %Calculates values of E, is 3x1

G = r .* (1 - sum(pop)*(1-E')./k);

%New: calculate Mu
alpha = 80;
b = 80;
deadliness = alpha.*(1-G);   %Linear assumption for D.
mu = doceLevel./(deadliness + b.*avgStrat);


G = G - mu;

%Calculate dUdt
newAvgStrat = max(calcdUdt(pop, avgStrat, currK_max, r, doceLevel, E, o, b, alpha) + avgStrat,0);

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
end

newPop = pop + pop .* G; %Find new populations

%keep all pops alive???
if(any(newPop<0.1))
    newPop(newPop<0.1) = 0.1;
    disp('Pop Saved')
end

newPorp = newPop./sum(newPop); %Calculate new porportion


end


