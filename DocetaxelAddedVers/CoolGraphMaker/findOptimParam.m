%Finds some nice param via brute force
%Variable to optimize
testVar = 'minAbi';
%Values to try
testValues = linspace(0,150,301);

%Initialize data
data = zeros(2,length(testValues));

%Run through lots of simuls and record data
for iSimuls = 1:length(testValues)
    eval([testVar ' = testValues(iSimuls);']);
    myMain;
    data(1,iSimuls) = failureTime;%abiCycleInfo(end,1);
    data(2,iSimuls) = cycleCount;
    eval(['disp(' testVar ')'])
    clearvars -except iSimuls data testValues testVar;
    
end

%Display results
figure(1)
plot(testValues,data(1,:));
xlabel('TI Porportion for Docetaxel Doseage')
ylabel('Simulation time until progression')
title('Impact of Therapy Strategies on Progression Time')
figure(2)
plot(testValues,data(2,:))

%Save data
save([testVar '.mat'])