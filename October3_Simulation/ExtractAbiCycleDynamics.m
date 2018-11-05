
abiON = zeros(length(treatmentIndex), 1);

abiON(treatmentIndex == 3) = 1;

abiCycle = 0;

for i = 1:1:length(treatmentIndex) - 2;
    %     for i = 1:1:100000
    
    if abiON(i + 1) - abiON(i) == 1;
        
        abiCycle = abiCycle + 1;
        
        abiCycleInfo(abiCycle, 1) = i;
        
        if (abiCycle > 1)
            abiCycleInfo(abiCycle, 3) = abiCycleInfo(abiCycle, 1) - abiCycleInfo(abiCycle - 1, 1);
        end
        
    elseif abiON(i + 1) - abiON(i) == -1;
        
        abiCycleInfo(abiCycle, 2) = i - abiCycleInfo(abiCycle, 1);
        
    end
    
end

abiCycleInfo(:,4) = abiCycleInfo(:,2)./365.* 30;
abiCycleInfo(:,5) = abiCycleInfo(:,3)./365;

for i = 1:size(abiCycleInfo, 1)
    fprintf('%d, %d, %d, %3.2f, %3.2f\n', abiCycleInfo(i, :))
end

clc
fprintf('Average cycle length = %3.2f\nAverage Abi per cycle = %3.2f\n', mean(abiCycleInfo(:,3)), mean(abiCycleInfo(:,2)));
fprintf('Std cycle length = %3.2f\nStd Abi per cycle = %3.2f\n', std(abiCycleInfo(2:end,3)), std(abiCycleInfo(:,2)));



