%% This code is going to set the initial conditions manually
% All models will start post_ADT.
% I will not be using NAIVE or ADT_ONLY before giving Abiraterone.


% Set PSA decay rate
sigmaPSA = 0.4;





% Best Case 21 Post Maximize TP
testCase_values(1,:) = [0.0100    0.02    0.03    0.4    0.95    0.99];
testCase_params(1,:) = {'b','f','a','e','d','c'};
PSA_IC(1) = 0;
x_IC(1,:) = [197.8048 * .1   21.9534 * .1 1];


% New case 1 Maximize T+
testCase_values(2,:) = [0.1    0.11   0.12  0.13    0.14   0.90];
testCase_params(2,:) = {'f','e','b','d','c','a'};
PSA_IC(2) = 0;
x_IC(2,:) = [197.8048 * .1   21.9534 * .1 0];


% Worst Case 14 Post Maximize T-
testCase_values(3,:) = [0.0100    0.02    0.9    0.91    0.95    0.96];
testCase_params(3,:) = {'b','d','f','a','e','c'};
PSA_IC(3) = 0;
x_IC(3,:) = [197.8048 * .1   21.9534 * .1 0];


% T+ = 0. TP = 90%. T- = 10% I can explicitly define the ESS using parameters d and f
testCase_values(4,:) = [1    1    1    0.9    1    0.1];
testCase_params(4,:) = {'a','b','c','d','e','f'};
PSA_IC(4) = 0;
x_IC(4,:) = [0  197.8048 * .1   21.9534 * .1];
 
% T+ = 0. TP = 50%. T- = 50% I can explicitly define the ESS using parameters d and f
testCase_values(5,:) = [1    1    1    0.5    1    0.5];
testCase_params(5,:) = {'a','b','c','d','e','f'};
PSA_IC(5) = 0;
x_IC(5,:) = [0  133 * 0.1    133 * 0.1];

% T+ = 90%. TP = 10%. T- = 0% I can explicitly define the ESS using parameters d and f
testCase_values(6,:) = [0.9    1    0.1    1    1    1];
testCase_params(6,:) = {'a','b','c','d','e','f'};
PSA_IC(6) = 0;
x_IC(6,:) = [197.8048 * .1   21.9534 * .1 0];

% T+ = 10%. TP = 90%. T- = 0% I can explicitly define the ESS using parameters d and f
testCase_values(7,:) = [0.001    1    0.999    1    1    1];
testCase_params(7,:) = {'a','b','c','d','e','f'};
PSA_IC(7) = 0;
x_IC(7,:) = [21.9534 * .1 197.8048 * .1 0];


%Initial Conditions

%Set time to 0.
time = 1;

% Set PSA to whatever value we think we will first give ABI.
PSA = 0;

% Set initial population values.
totalPopulation = 1;
x = [totalPopulation * 0.1 totalPopulation * 0.4, totalPopulation * 0.5];

% TreatmentRegimen
% 0; ADT Only
% 1; SOC Abi
% 2; Cycle Abi
treatment = 2;

for TestCaseIndex = 1
    
    disp(TestCaseIndex)
    values = testCase_values(TestCaseIndex, :);
    params = testCase_params(TestCaseIndex, :);
    PSA = PSA_IC(TestCaseIndex);
    x = x_IC(TestCaseIndex,:);
    
    
    if (treatment == 0)
        
        % ADT ONLY
        PSA_GiveABI = inf;
        
        ADT_ONLY;
        
        SimulationEndFunction;
        
        
        
    elseif (treatment == 1)
        
        % Constant ABI
        PSA_GiveABI = 200;
        
        initialFlag =1;
        
        ADT_ONLY;
        
        PSA_StopABI = 0;
        
        ABI_ADT;
        
        SimulationEndFunction;
        
        
    elseif (treatment == 2)
        % Cycle ABI
        PSA_GiveABI = 100;
        PSA_StopABI = 50;
        
        % Always give one cycle of ABI
        cycleNum = 0;
        nextCycleFlag = 1;
        
        initialFlag =1;
        
        while (nextCycleFlag == 1)
            cycleNum = cycleNum + 1;
            fprintf('Cycle %d\n', cycleNum)
            ADT_ONLY;
            ABI_ADT;
        end
        
        SimulationEndFunction;
        ExtractAbiCycleDynamics;
        
        
    end
    
end

