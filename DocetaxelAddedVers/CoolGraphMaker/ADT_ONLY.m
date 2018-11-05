%% Post-ADT

% Set growth rates
r = [0.005, 0.002, 0.001];

% Set carrying capacities
k_max = min([0, 200, 200],k_max);
k_max(3) = 200;
% Set max symbiotic level
%if ~exist('X', 'var')
    X = 500;
%end

% Assign values for current order index
for i = 1:1:6
    assignin('base', cell2mat(params(1,i)), values(i));
end

%Create matrix
payoffMatrix = [0 a b; c 0 d; e f 0];

startFlag = 1;
while (PSA < PSA_GiveABI || startFlag == 1)
    time = time + 1;
    
    if (PSA < PSA_GiveABI)
        startFlag = 0;
    end
    
    p = x./sum(x);
    
    delayCounterThing = delayCounterThing - 1;
    
    k_max(1) = p(2) * X;
    
    %Change K
    if k_max(2) ~= 200
        k_max(2) = createDownSlope(find(createDownSlope==k_max(2)) - 1);
    end
    
    %Change X
%     if X ~= 500
%         X = createDownSlope(find(createDownSlope==X) - 1);
%     end
    
    kTracker = [kTracker; k_max];

    
    [x, p] = growCancer(x, r, k_max, payoffMatrix, doceLevel);
    
    doceLevel = max(doceLevel*(1-doceDecay), 0);    %Decay Doce
    doceTracker(time) = doceLevel;

    
    delta_PSA = getDeltaPSA(x, p);
    PSA = PSA + delta_PSA - sigmaPSA*PSA;

    all_x(time,:) = x;
    all_p(time, :) = p;
    all_PSA(time) = PSA;
    
    
end