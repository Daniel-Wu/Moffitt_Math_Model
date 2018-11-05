function [newPop, newPorp, newAvgStrat] = growCancer(pop, r, currK_max, coeff, doceLevel, avgStrat, o)
%growCancer(population, r, k, coeff)   Calculates and returns new 
%population of cancer cells, using the G function.
%Vectorized verion

s = 0.01;%0.05; %0.1;  %Speed of evolution

porp = pop./sum(pop);
E = coeff * porp';      %Calculates values of E, is 3x1
x = sum(pop);
findK = @(v)(currK_max.*exp(-(v.*v)/(2*o)));

G = calcG(r, x, E, findK(avgStrat), doceLevel, avgStrat);

%Calculate dUdt
dGdv = (calcG(r, x, E, findK(avgStrat+0.001), doceLevel, avgStrat+0.001) ...
    - calcG(r, x, E, findK(avgStrat-0.001), doceLevel, avgStrat-0.001))/0.002;

newAvgStrat = min(avgStrat + s*dGdv, 1);

%Record the fitness data - takes extremely long time
%recordFitness;


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


