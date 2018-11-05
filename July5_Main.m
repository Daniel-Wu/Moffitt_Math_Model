

%% These are all 22 Post-ADT matrix orders
% Currently unused.

% testOrders = {...
%     'f','e','b','d','c','a';...
%     'f','e','b','d','a','c';...
%     'f','e','b','a','d','c';...
%     'f','b','d','e','c','a';...
%     'f','b','d','e','a','c';...
%     'f','b','d','a','e','c';...
%     'f','b','e','d','c','a';...
%     'f','b','e','d','a','c';...
%     'f','b','e','a','d','c';...
%     'f','b','a','e','d','c';...
%     'f','b','a','d','e','c';...
%     'b','d','f','e','c','a';...
%     'b','d','f','e','a','c';...
%     'b','d','f','a','e','c';...
%     'b','f','d','e','c','a';...
%     'b','f','d','e','a','c';...
%     'b','f','d','a','e','c';...
%     'b','f','e','d','c','a';...
%     'b','f','e','d','a','c';...
%     'b','f','e','a','d','c';...
%     'b','f','a','e','d','c';...
%     'b','f','a','d','e','c';...
%     };
% params = testOrders(21,:);

% Set PSA decay rate
sigmaPSA = 0.3;


%1 = Constant Abi. 0 = Cycling.
constantAbi = 0;



% Naive Pre-Lupron
% values = [0.0100    0.2060    0.4020    0.5980    0.7940    0.99];

% Best Case 21 Post Maximize TP
testCase_values(1, :) = [0.0100    0.02    0.03    0.4    0.95    0.99];
testCase_params(1, :) = {'b','f','a','e','d','c'};

% New case 1 Maximize T+
testCase_values(2,:) = [0.1    0.11   0.12  0.13    0.14   0.90];
testCase_params(2,:) = {'f','e','b','d','c','a'};

% Worst Case 14 Post Maximize T-
testCase_values(3,:) = [0.0100    0.02    0.9    0.91    0.95    0.96];
testCase_params(3,:) = {'b','d','f','a','e','c'};

%
% % Middle ground 17 equal Post
% testCase_values(3,:) = [0.994    0.995   0.996   0.997    0.998   0.999];
% testCase_params(3,:) = {'b','f','d','a','e','c'};




for TestCaseIndex = 2
    
    disp(TestCaseIndex)
    values = testCase_values(TestCaseIndex, :);
    params = testCase_params(TestCaseIndex, :);
    
    
    % ADT ONLY
    %         PSA_GiveADT = 80;
    %         PSA_GiveABI = 600;
    %
    %         NAIVE;
    %
    %         ADT_ONLY;
    %
    %         SimulationEndFunction;
    
    
    
    if (constantAbi == 1)
        
        % Constant ABI
        PSA_GiveADT = 80;
        PSA_GiveABI = 100;
        PSA_StopABI = 0;
        
        NAIVE;
        
        ADT_ONLY;
        
        ABI_ADT;
        
        SimulationEndFunction;
        
        
    else
        % Cycle ABI
        PSA_GiveADT = 80;
        PSA_GiveABI = 100;
        PSA_StopABI = 50;
        
        NAIVE;
        
        % Always give one cycle of ABI
        cycleNum = 0;
        nextCycleFlag = 1;
        
        while (nextCycleFlag == 1)
            cycleNum = cycleNum + 1;
            fprintf('Cycle %d\n', cycleNum)
            %             ADT_ONLY;
            %             ABI_ADT;
            
                        ADT_ONLY_DOX;
                        ABI_ADT;
            
%             ADT_ONLY;
%             ABI_ADT_DOX;
            
        end
        
        SimulationEndFunction;
        ExtractAbiCycleDynamics;
        
        
    end
    
end







