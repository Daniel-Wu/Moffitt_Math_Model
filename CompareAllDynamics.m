

smoothing = 100;

all_x(45000:48000, 3) = 0.1;

for i = 1:1:length(all_x)-smoothing
    smoothedTplus(i) = median(all_x(i:i+smoothing-1, 1));
    smoothedTp(i) = median(all_x(i:i+smoothing-1, 2));
    smoothedTminus(i) = median(all_x(i:i+smoothing-1, 3));

end


% for i = 1:1:length(AAAall_x)-smoothing
%     smoothedTplus2(i) = median(AAAall_x(i:i+smoothing-1, 1));
%     smoothedTp2(i) = median(AAAall_x(i:i+smoothing-1, 2));
%     smoothedTminus2(i) = median(AAAall_x(i:i+smoothing-1, 3));
% 
% end





figure

subplot(2, 1, 1)
hold on

rectangle('Position',[20000,0,7000,450],'FaceColor',[.9 .9 .9],'EdgeColor','none')
[AX, h1, h2] = plotyy(1:1:length(smoothedTplus), smoothedTplus, 1:1:length(smoothedTminus), smoothedTminus);
plot(AX(1), 1:1:length(smoothedTp), smoothedTp, 'Color', [0.74, .42, 1] , 'LineWidth', 4);

set(h1, 'Color', [0.0, .57, .57], 'LineWidth', 4);
set(h2, 'Color', [0.91 0.41 0.17], 'LineWidth', 4);

set(AX(1), 'xlim', [19500 27000], 'ylim', [0 450], 'FontSize', 24);
set(AX(2), 'xlim', [19500 27000], 'ylim', [0 10], 'FontSize', 24);

subplot(2, 1, 2)
hold on

% rectangle('Position',[19950,0,200,450],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[22500,0,200,450],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[25000,0,200,450],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% 
% [AX, h1, h2] = plotyy(1:1:length(smoothedTplus2), smoothedTplus2, 1:1:length(smoothedTminus2), smoothedTminus2);
% plot(AX(1), 1:1:length(smoothedTp2), smoothedTp2, 'Color', [0.74, .42, 1] , 'LineWidth', 4);
% 
% set(h1, 'Color', [0.0, .57, .57], 'LineWidth', 4);
% set(h2, 'Color', [0.91 0.41 0.17], 'LineWidth', 4);
% 
% set(AX(1), 'xlim', [19500 27000], 'ylim', [0 450], 'FontSize', 24);
% set(AX(2), 'xlim', [19500 27000], 'ylim', [0 0.8], 'FontSize', 24);

% figure
% subplot(3, 2, 1)
% hold on
% rectangle('Position',[20000,0,7000,100],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% plot(smoothedTplus, 'Color', [0.0, .57, .57], 'LineWidth', 4);
% xlim([19500 27000])
% ylim([0 100])
% set(gca,'Xtick',[20000 22000 24000 26000])
% set(gca,'XtickLabel', [0 2000 4000 6000])
% set(gca, 'FontSize', 20)
% title('MTD', 'FontSize', 30)
% ylabel(sprintf('T+\nPopulation Size'), 'FontSize', 24)
% 
% subplot(3, 2, 3)
% hold on
% rectangle('Position',[20000,0,7000,400],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% plot(smoothedTp, 'Color', [0.74, .42, 1] , 'LineWidth', 4);
% xlim([19500 27000])
% ylim([0 400])
% set(gca,'Xtick',[20000 22000 24000 26000])
% set(gca,'XtickLabel', [0 2000 4000 6000])
% set(gca, 'FontSize', 20)
% ylabel(sprintf('TP\nPopulation Size'), 'FontSize', 24)
% 
% subplot(3, 2, 5)
% hold on
% rectangle('Position',[20000,0,7000,0.4],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% plot(smoothedTminus, 'Color', [0.91 0.41 0.17], 'LineWidth', 4);
% xlim([19500 27000])
% ylim([0 0.4])
% set(gca,'Xtick',[20000 22000 24000 26000])
% set(gca,'XtickLabel', [0 2000 4000 6000])
% set(gca, 'FontSize', 20)
% ylabel(sprintf('T-\nPopulation Size'), 'FontSize', 24)
% xlabel(sprintf('Simulated Time'), 'FontSize', 24)
% 
% 
% subplot(3, 2, 2)
% hold on
% rectangle('Position',[19950,0,200,100],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[22500,0,200,100],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[25000,0,200,100],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% plot(smoothedTplus2, 'Color', [0.0, .57, .57], 'LineWidth', 4);
% xlim([19500 27000])
% ylim([0 100])
% set(gca,'Xtick',[20000 22000 24000 26000])
% set(gca,'XtickLabel', [0 2000 4000 6000])
% set(gca, 'FontSize', 20)
% title('Adaptive Therapy', 'FontSize', 30)
% 
% 
% subplot(3, 2, 4)
% hold on
% rectangle('Position',[19950,0,200,400],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[22500,0,200,400],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[25000,0,200,400],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% plot(smoothedTp2, 'Color', [0.74, .42, 1] , 'LineWidth', 4);
% xlim([19500 27000])
% ylim([0 400])
% set(gca,'Xtick',[20000 22000 24000 26000])
% set(gca,'XtickLabel', [0 2000 4000 6000])
% set(gca, 'FontSize', 20)
% 
% subplot(3, 2, 6)
% hold on
% rectangle('Position',[19950,0,200,.4],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[22500,0,200,.4],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% rectangle('Position',[25000,0,200,.4],'FaceColor',[.9 .9 .9],'EdgeColor','none')
% plot(smoothedTminus2, 'Color', [0.91 0.41 0.17], 'LineWidth', 4);
% xlim([19500 27000])
% ylim([0 0.4])
% set(gca,'Xtick',[20000 22000 24000 26000])
% set(gca,'XtickLabel', [0 2000 4000 6000])
% set(gca, 'FontSize', 20)
% xlabel(sprintf('Simulated Time'), 'FontSize', 24)

