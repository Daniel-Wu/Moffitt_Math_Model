
begin_x = 1;
y_max = 500;
x_max = 100000;

time

disp('Creating figure')

figure1 = figure('Color',[1 1 1]);

subplot(3, 1, 1)
hold on

% if (constantAbi == 6)
%     abiStart = find(treatmentIndex == 3, 1, 'first');
%     plot([abiStart-begin_x abiStart-begin_x], [0 y_max], 'k', 'LineWidth', 6);
% else
%     for i = begin_x:1:time
%         if ( treatmentIndex(i) == 3 )
%             plot([i-begin_x i-begin_x], [0 y_max], 'Color', [0.9, 0.9, 0.9])
%         end
%     end
% end


h1 = plot(all_x(begin_x:end,1), 'Color', [0.0, .57, .57] , 'LineWidth', 6, 'DisplayName', 'T+');
h2 = plot(all_x(begin_x:end,2), 'LineStyle',':', 'Color', [0.74, .42, 1] , 'LineWidth', 6, 'DisplayName', 'TP');
h3 = plot(all_x(begin_x:end,3), 'LineStyle','--', 'Color', [0.91 0.41 0.17] , 'LineWidth', 6, 'DisplayName', 'T-');
h4 = plot(sum(all_x(begin_x:end, :), 2), 'Color', [0.5, .5, .5] , 'LineWidth', 1, 'DisplayName', 'Total Population');
xlabel('Simulated Time', 'FontSize', 34)
ylabel(sprintf('Population \nSize'), 'FontSize', 34)

xlim([19000 65000])
ylim([0 y_max])
legend ([h1 h2 h3 h4], {'T+' 'TP' 'T-' 'Total Population'}, 'FontSize', 28);
set(gca, 'FontSize', 30)

subplot(3, 1, 2)
hold on

% if (constantAbi == 6)
%     abiStart = find(treatmentIndex == 3, 1, 'first');
%     plot([abiStart-begin_x abiStart-begin_x], [0 y_max],  'k', 'LineWidth', 6);
% else
%     for i = begin_x:1:time
%         if ( treatmentIndex(i) == 3 )
%             plot([i-begin_x i-begin_x], [0 y_max], 'Color', [0.9, 0.9, 0.9])
%         end
%     end
% end

h5 = plot(all_p(begin_x:end,1), 'Color', [0.0, .57, .57] , 'LineWidth', 6, 'DisplayName', 'T+');
h6 = plot(all_p(begin_x:end,2), 'LineStyle',':', 'Color', [0.74, .42, 1] , 'LineWidth', 6, 'DisplayName', 'TP');
h7 = plot(all_p(begin_x:end,3), 'LineStyle','--', 'Color', [0.91 0.41 0.17] , 'LineWidth', 6, 'DisplayName', 'T-');
xlabel('Simulated Time', 'FontSize', 34)
ylabel(sprintf('Population \nFrequency'), 'FontSize', 34)
% xlim([1 time-1])
xlim([19000 65000])

ylim([0 1]);
legend ([h5 h6 h7], {'T+' 'TP' 'T-'}, 'FontSize', 28);
set(gca, 'FontSize', 30)

subplot(3, 1, 3)
hold on

% if (constantAbi == 6)
%     abiStart = find(treatmentIndex == 3, 1, 'first');
%     plot([abiStart-begin_x abiStart-begin_x], [0 y_max],  'k', 'LineWidth', 6);
% else
%     for i = begin_x:1:time
%         if ( treatmentIndex(i) == 3 )
%             plot([i-begin_x i-begin_x], [0 y_max], 'Color', [0.9, 0.9, 0.9])
%         end
%     end
% end

% Uncomment this if you want to see true PSA values. Commented with have it
% be relative values. 
PSA_GiveABI = 1;

plot(all_PSA(begin_x:end)./PSA_GiveABI, 'k' , 'LineWidth', 6);
hold on

inSet = 0;
for i = 20000:1:length(all_PSA)
    
    if (treatmentIndex(i) == 3 && inSet == 0);
        redStart = i;
        inSet = 1;
    end
    
    if (treatmentIndex(i) ~= 3 && inSet == 1);
        redStop = i;
        inSet = 0;
        
        plot(redStart:redStop, all_PSA(redStart:redStop)./PSA_GiveABI, 'r' , 'LineWidth', 6);
    end
    
end

if (inSet == 1)
    plot(redStart:length(all_PSA), all_PSA(redStart:end)./PSA_GiveABI, 'r' , 'LineWidth', 6);
end

% plot(20000:length(all_PSA), all_PSA(20000:end)./PSA_GiveABI, 'r' , 'LineWidth', 6);
% xlim([begin_x:end time])
xlim([19000 65000])

ylim([0 1.5])
xlabel('Simulated Time', 'FontSize', 34)
ylabel(sprintf('Normalized \nPSA'), 'FontSize', 34)
set(gca, 'FontSize', 30)
