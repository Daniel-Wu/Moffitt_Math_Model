%Plots simulation results
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

plot(popData(:,1),'k', 'lineWidth',3)
plot(popData(:,2),':g','lineWidth',3)
plot(popData(:,3),'--r','lineWidth',3)
%plot(sum(popData, 2), 'c', 'lineWidth', 3)

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

plot(popPorpData(:,1),'k','lineWidth',3)
plot(popPorpData(:,2),':g','lineWidth',3)
plot(popPorpData(:,3),'--r','lineWidth',3)


subplot(3,1,3) %PSA
hold on;
xlabel('Time')
ylabel('PSA Level')
plot(PSAData)

%DEBUG Resistances
figure
plot(doceResistTracker)
legend('T+', 'Tp', 'T-')
xlabel('Time')
ylabel('Resistance')