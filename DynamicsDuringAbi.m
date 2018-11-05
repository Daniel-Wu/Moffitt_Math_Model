%% Cycles from testCase1

smoothing = 50;

diffTplus = diff(all_x(:,1));
diffTproduce = diff(all_x(:,2));
diffTmuinus = diff(all_x(:,3));


for i = 1:1:length(diffTproduce)-smoothing
    smoothed_Tproduce(i) = mean(diffTproduce(i:i+smoothing-1));
end

for i = 1:1:length(diffTmuinus)-smoothing
    smoothed_Tminus(i) = mean(diffTmuinus(i:i+smoothing-1));
end

for i = 1:1:length(diffTplus)-smoothing
    smoothed_Tplus(i) = mean(diffTplus(i:i+smoothing-1));
end


figure
hold on

% rectangle('Position',[34610,-0.4,370,.5],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[36930,-0.4,370,.5],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[39190,-0.4,370,.5],'FaceColor',[.9 .9 .9],'EdgeColor','none')

plot(smoothed_Tplus, 'Color', [0.0, .57, .57] , 'LineWidth', 6, 'DisplayName', 'T+');
plot(smoothed_Tproduce .* 0.5, 'LineStyle','-', 'Color', [0.74, .42, 1] , 'LineWidth', 6, 'DisplayName', 'TP');
plot(smoothed_Tminus .* 50, 'LineStyle','-', 'Color', [0.91 0.41 0.17] , 'LineWidth', 6, 'DisplayName', 'T-');


xlim([34000 40000])
ylim([-0.4 0.1])

legend ({'T+' 'TP' 'T-'}, 'FontSize', 28);




%% SOC from testCase1

diffTplus = diff(all_x(:,1));
diffTproduce = diff(all_x(:,2));
diffTmuinus = diff(all_x(:,3));


for i = 1:1:length(diffTproduce)-300
    smoothed_Tproduce(i) = mean(diffTproduce(i:i+299));
end

for i = 1:1:length(diffTmuinus)-300
    smoothed_Tminus(i) = mean(diffTmuinus(i:i+299));
end

for i = 1:1:length(diffTplus)-300
    smoothed_Tplus(i) = mean(diffTplus(i:i+299));
end


figure
hold on
% 
rectangle('Position',[19700,-1.5,12000,3.5],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[36930,-0.4,370,.5],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[39190,-0.4,370,.5],'FaceColor',[.9 .9 .9],'EdgeColor','none')

plot(smoothed_Tplus(1:20000), 'Color', [0.0, .57, .57] , 'LineWidth', 4, 'DisplayName', 'T+');
plot(smoothed_Tproduce(1:20000) .* 0.5, 'LineStyle',':', 'Color', [0.74, .42, 1] , 'LineWidth', 4, 'DisplayName', 'TP');
plot(smoothed_Tminus .* 10, 'LineStyle','--', 'Color', [0.91 0.41 0.17] , 'LineWidth', 4, 'DisplayName', 'T-');


xlim([17000 29000])
ylim([-1.5 2])

legend ({'T+' 'TP' 'T-'}, 'FontSize', 20);




