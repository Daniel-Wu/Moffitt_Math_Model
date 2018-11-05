%% Post-ADT

% Set growth rates
r = [0.005, 0.002, 0.001];

% Set carrying capacities
k_max = [0, 400, 400];

% Set max symbiotic level
X = 2;

% Assign values for current order index
for i = 1:1:6
    assignin('base', cell2mat(params(1,i)), values(i));
end

%Create matrix
payoffMatrix = [0 a b; c 0 d; e f 0];

startFlag = 1;
while (PSA < PSA_GiveABI || startFlag == 1||initialFlag == 1)
    time = time + 1;
    
    % TreatmentIndex = 2 for ADT Only
    treatmentIndex(time) = 2;
    
    if (time == 20000)
        initialFlag = 0;
        PSA_GiveABI = PSA - 1;
        PSA_StopABI = PSA_GiveABI/2;
    end
    
    if (PSA < PSA_GiveABI)
        startFlag = 0;
    end
    
    p = x./sum(x);
    
    k_max(1) = x(2) * X;
    
    % Get dynamics
    for i = 1:1:3
        
        E(i) = payoffMatrix(i,:) * p';
        
        G(time, i) = r(i) * (k_max(i) - (1-E(i)) * sum(x))/k_max(i);
        
        if(G(time, i) == -inf)
            G(time, i) = -1;
        end
        
        delta_x(i) = x(i) * G(time, i);
        
    end
    
    x = x + delta_x;
    
%     if(x(1) <= 0.1)
%         x(1) = 0.1;
%     end
%     
%     if(x(2) <= 0.1)
%         x(2) = 0.1;
%     end
%     
%     if(x(3) <= 0.1)
%         x(3) = 0.1;
%     end
    
    delta_PSA = getDeltaPSA(x, p);
    PSA = PSA + delta_PSA - sigmaPSA*PSA;
    
    
    all_x(time,:) = x;
    all_p(time, :) = p;
    all_PSA(time) = PSA;
    
    if ( time > 100000)
        break;
    end
    
    
    
end