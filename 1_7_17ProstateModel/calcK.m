function [newK, newK_max] = calcK(K_max, popPorp, abiLevel, avgStrat, o)
%calcK determines new K for each time step
%   Taking K_max, popPorp, abiLevel, and avg strat, calculates and returns
%   K
global time;
%Init newK
newK_max(1) = popPorp(2).*(500-abiLevel);          %Change K of T+ based on Tp pop
newK_max(2) = K_max(2) - abiLevel;
newK_max(3) = K_max(3);

newK = newK_max.*exp(-(avgStrat.^2)./(2.*o));

if any(newK<0)     %Catch K in case it becomes nonnegative
    newK(newK<0) = 0;
    disp(['k went negative at time ' num2str(time)])
end

end