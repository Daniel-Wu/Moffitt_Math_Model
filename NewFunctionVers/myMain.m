%My shot at the discrete function - models prostate dynamics system
%I tried making an explicit abiraterone quantity
clc; clear all;

%% Var Init
%Simul Params
endTime = 50000;
time = 0;
plotResults = 1;

%Set coefficients here
a = 0.5;
b = 0.99;
c = 0.01;
d = 0.04;
e = 0.03;
f = 0.02;
preCoeffMat = [0 a b; c 0 d; e f 0];   %Nice matrix of coefficients

%Post Luperon
%Jessica's worst case
a = 0.91;
b = 0.01;
c = 0.96;
d = 0.02;
e = 0.95;
f = 0.9;
postCoeffMat = [0 a b; c 0 d; e f 0];   %Nice matrix of coefficients

clear a b c d e f; %Clean up

%Values of R and K
rPreLup = [0.005, 0.002, 0.001];
kInitPreLup = [600 200 100];
kPreLup = kInitPreLup;
rPreAbi  = [0.005 0.002 0.001];
rPostAbi = [0.001 0.001 0.001];
kInitPostLup = [0 200 200];
kPostLup = kInitPostLup;
currK_max = [0 0 0];  %Holder for current k max variable

%Misc vars
o = 1;  %(Measure of cost of resistance)^2
failure = false; %Treatment failure status

%Population init
testo = 0;
pop = [0.1 0.1 0.1];           %[T+ Tp T-]
PSA = 0;
testoPSAImpactPreLup = [0.1 0.8 0.8];
testoPSAImpactPostLup = [0.01 0.006, 0.006];
basePSAProdPreLup = [0 0 0];
basePSAProdPostLup = [0 0.5 0.5];
PSADecay = 0.3;
avgDoceResistance = [0 0 0];   %Determines K and resistance to doce.

%Drug variables
abiLevel = 0;
abiDose = 5;
abiDecay = 0.05;
%%
minAbi = 0;
%%
doceLevel = 0;
doceDose = 10;%10;%200;
doceDecay = 0.05;
doceTreatTIPorp = 0.5; %Porportion of TI at which to give doce.
doceDoseWait = 200;
doceDoseTimer = 0; %When <=0 dose can be given. When dose is given,
%is set to doceDoseWait, and decreased by 1 each time step.

%Data recording
popData = nan(endTime,3);
popData(1,:) = pop;

PSAData = nan(endTime,1);
cycleCount = 0;

popPorp = pop./sum(pop);
popPorpData = nan(endTime,3);
popPorpData(1,:) = popPorp;

abiTracker = nan(endTime,1);
doceTracker = nan(endTime,1);

doceTimes = [];
abiStartTimes = [];
abiStopTimes = [];

doceResistTracker = nan(endTime,3);

%PSA Brightlines
PSA_GiveADT = 80;
PSA_GiveAbi = 300;
PSA_StopAbi = PSA_GiveAbi*0.999;


%% Simul
%Carcinogenesis
    while PSA<PSA_GiveADT           %While we are off Luperon
        
        time = time + 1;            %Increment time
                
        %Administer doce, perhaps
        doceDoseTimer = doceDoseTimer - 1;   %decrement timer
        if (popPorp(3)>doceTreatTIPorp && doceDoseTimer<=0) %Change <= into > to deactivate
           doceLevel = doceLevel + doceDose;   %Give dose
           doceTimes = [doceTimes time];       %Record dose time
           doceDoseTimer = doceDoseWait;       %Add time to timer
        end
        
        
        currK_max = kPreLup;   %K is unadjusted by anything during carcinogenesis
        [pop, popPorp, avgDoceResistance] = growCancer(pop, rPreLup, kPreLup, currK_max, preCoeffMat,doceLevel, avgDoceResistance, o);
        PSA = PSA*(1-PSADecay) + sum(pop.*testoPSAImpactPreLup);          %Not t+ dependant nvm calcPSA(pop, popPorp, PSA, PSADecay, testoPSAImpactPreLup, basePSAProdPreLup);

        %Decay drugs
        doceLevel = max(doceLevel*(1-doceDecay), 0);
        abiLevel = max(abiLevel*(1-abiDecay), minAbi);
        
        %Record Data
        popData(time, :) = pop;
        popPorpData(time, :) = popPorp;
        PSAData(time) = PSA;
        doceTracker(time) = doceLevel;
        abiTracker(time) = abiLevel;
        doceResistTracker(time,:) = avgDoceResistance;
    end     

    
while true
    
    if (time>=endTime || failure)        %Check to see if we should stop the simul
        break;
    end
    
    disp(['Cycle ' num2str(cycleCount) ' complete.'])
    cycleCount = cycleCount + 1; %Count cycles
    
    
    while PSA<PSA_GiveAbi           %While we are off abi
        
        time = time + 1;            %Increment time
        
        if time>=endTime        %Check to see if we should stop the simul
            break
        end
        
        %Administer doce, perhaps
        doceDoseTimer = doceDoseTimer - 1;      %Decrement timer
        if (popPorp(3)>doceTreatTIPorp && doceDoseTimer<=0) %Change <= into > to deactivate
           doceLevel = doceLevel + doceDose;    %Apply dose
           doceTimes = [doceTimes time];        %Record dose time
           doceDoseTimer = doceDoseWait;        %Add time to timer
        end
        
        %Calc K
        [kPostLup, currK_max] = calcK(kInitPostLup, popPorp, abiLevel, avgDoceResistance, o);

        [pop, popPorp, avgDoceResistance] = growCancer(pop, rPreAbi, kPostLup, currK_max, postCoeffMat,doceLevel, avgDoceResistance, o);
        PSA = calcPSA(pop, popPorp, PSA, PSADecay, testoPSAImpactPostLup, basePSAProdPostLup);
        
        
        
        %Decay drugs
        doceLevel = max(doceLevel*(1-doceDecay), 0);
        abiLevel = max(abiLevel*(1-abiDecay), minAbi);
        
        %Record Data
        popData(time, :) = pop;
        popPorpData(time, :) = popPorp;
        PSAData(time) = PSA;
        doceTracker(time) = doceLevel;
        abiTracker(time) = abiLevel;
        doceResistTracker(time,:) = avgDoceResistance;

        %% Debug
        kTracker(time,:) = kPostLup;
    end     %End of vacation
    
    
    incomingPSA = PSA;
    
    abiStartTimes = [abiStartTimes, time];
    
    while PSA>PSA_StopAbi           %Until we can reach that brightline, we treat
        
        
        time = time + 1;            %Increment time
        
        if time>=endTime        %Check to see if we should stop the simul
            break
        end
        
        
        %Administer doce, perhaps
        doceDoseTimer = doceDoseTimer - 1;      %Decrement timer
        if (popPorp(3)>doceTreatTIPorp && doceDoseTimer<=0) %Change <= into > to deactivate
           doceLevel = doceLevel + doceDose;    %Give doce
           doceTimes = [doceTimes time];        %Record drug time
           doceDoseTimer = doceDoseWait;        %Add time to timer
        end
        
        %Continuously add in abi
        abiLevel = abiLevel + abiDose;
        
        %Calc K
        [kPostLup, currK_max] = calcK(kInitPostLup, popPorp, abiLevel, avgDoceResistance, o);

        [pop, popPorp, avgDoceResistance] = growCancer(pop, rPostAbi, kPostLup, currK_max, postCoeffMat,doceLevel, avgDoceResistance, o);
        PSA = calcPSA(pop, popPorp, PSA, PSADecay, testoPSAImpactPostLup, basePSAProdPostLup);
        
        %Check for treatment failure
        if PSA>incomingPSA*1.1
            failureTime = time;
            disp(['Treatment failure at time ' num2str(time)]);
            failure = true;
            break;
        end
        
        %Decay drugs
        doceLevel = max(doceLevel*(1-doceDecay), 0);
        abiLevel = max(abiLevel*(1-abiDecay), minAbi);
        
        %Record Data
        popData(time, :) = pop;
        popPorpData(time, :) = popPorp;
        PSAData(time) = PSA;
        doceTracker(time) = doceLevel;
        abiTracker(time) = abiLevel;
        doceResistTracker(time,:) = avgDoceResistance;

        %% Debug
        kTracker(time,:) = kPostLup;
    end     %end of treatment
    
    abiStopTimes = [abiStopTimes, time];
    
end

%% Plot Results
if plotResults
    figure
    subplot(3,1,1) %Populations
    hold on;
    xlabel('Time')
    ylabel('Population')
    
    %Draw treatment lines
    for i = 1:length(abiStartTimes)
        area([abiStartTimes(i), abiStopTimes(i)], [200 200],'FaceColor',[0.1 0.1 0.1],'lineStyle','none')
    end
    for i = 1:length(doceTimes)
        line([doceTimes(i) doceTimes(i)], [0 250],'color','k','lineWidth',1)
    end
    
    plot(popData(:,1),'b', 'lineWidth',3)
    plot(popData(:,2),':g','lineWidth',3)
    plot(popData(:,3),'--r','lineWidth',3)

    
    subplot(3,1,2) %Porportions
    hold on;
    xlabel('Time')
    ylabel('Population porportions')
    
    %Draw treatment lines
    for i = 1:length(abiStartTimes)
        area([abiStartTimes(i), abiStopTimes(i)], [0.8 0.8],'FaceColor',[0.1 0.1 0.1],'lineStyle','none')
    end
    for i = 1:length(doceTimes)
        line([doceTimes(i) doceTimes(i)], [0 1],'color','k','lineWidth',1)
    end
    
    plot(popPorpData(:,1),'b','lineWidth',3)
    plot(popPorpData(:,2),':g','lineWidth',3)
    plot(popPorpData(:,3),'--r','lineWidth',3)

    
    subplot(3,1,3) %PSA
    hold on;
    xlabel('Time')
    ylabel('PSA Level')
    plot(PSAData)
end
