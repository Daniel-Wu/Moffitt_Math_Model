%% Abiraterone Treatment

% Set growth rates
r = [0.005/2, 0.002/2, 0.001/2];

% Set carrying capacities
k_max = [0, 400*2, 400];


% Abiraterone affects the level that T+ can benefit from TP

% Set max symbiotic level
X = 1.5;

AbiLength = 50000;
createDownSlope = X*(exp(0.1 * (1-(1:AbiLength))));

X(time:time + AbiLength - 1) = createDownSlope';

createDownSlope = 400*(exp(0.05 * (1-(1:AbiLength))));
k_TP(time:time + AbiLength - 1) = createDownSlope';

% Assign values for current order index
for i = 1:1:6
    assignin('base', cell2mat(params(1,i)), values(i));
end

%Create matrix
payoffMatrix = [0 a b; c 0 d; e f 0];

IncomingPSA = PSA;

while (PSA >= PSA_StopABI)
    time = time + 1;
    
%     if(time > 50000)
%         break;
%     end
    
    % TreatmentIndex = 3 for Abi
    treatmentIndex(time) = 3;
    
    p = x./sum(x);
    
    if (p(3) > 0.99)
        k_max(3) = 10000;
    end
    
    k_max(1) = x(2) * X(time);
    k_max(2) = k_TP(time);
    
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
    
%     if isnan(x(1))
%         x(1) = 0;
%     end
   
    
        if(x(1) <= 0.1)
            x(1) = 0.1;
        end
    
        if(x(2) <= 0.1)
            x(2) = 0.1;
        end
    
        if(x(3) <= 0.1)
            x(3) = 0.1;
        end
    
    delta_PSA = getDeltaPSA(x, p);
    PSA = PSA + delta_PSA - sigmaPSA*PSA;
    
    
    all_x(time,:) = x;
    all_p(time, :) = p;
    all_PSA(time) = PSA;
    
    % Enter abiraterone failure catch. If we are in constant ABI then just stop at 10% above.
    % If we are in cycles and don't see a decrease in PSA from ABI then break out.
    
    
    if (PSA >= IncomingPSA * 2 || time > 100000)
        disp('Abiraterone Failure 10% greater than incoming')
        nextCycleFlag = 0;
        break;
    else
        nextCycleFlag = 1;
    end
    
    
end