function plotSelectedTraj(selectedTraj,featureFig,trackers,genotypes,tracker,genotype,wormIDs)

featureTFig = figure;
%set(0,'CurrentFigure',featureFig); hold on
all_x = selectedTraj(:,2);
all_y = selectedTraj(:,3);
all_t = selectedTraj(:,4);
% keep track of trajectory length
trackLength = NaN(numel(wormIDs),2);
for wormCtr = 1:numel(wormIDs)
    worm = wormIDs(wormCtr);
    rowInd = find(selectedTraj(:,1) == worm);
    %subplot(numel(trackers),numel(genotypes),fileCtr)
    set(0,'CurrentFigure',featureTFig);
    plot3(all_x(rowInd), all_y(rowInd),all_t(rowInd))
    hold on
    trackLength(wormCtr,1) = worm;
    trackLength(wormCtr,2) = numel(rowInd);
end
% axis equal
set(0,'CurrentFigure',featureTFig);
xlim([0 2500])
ylim([0 2500])
xlabel('x')
ylabel('y')
zlabel('t')
title([genotype tracker])
grid on

% plot track length distribution
set(0,'CurrentFigure',featureFig);
hold on
if numel(genotypes)~=1
    subplot(1,numel(genotypes),find(strcmp(genotypes, genotype)))
end
histogram(trackLength(:,2),'BinWidth',9,'Normalization','Probability','DisplayStyle','stairs')
xlim([0 600])
xlabel('frames')
ylabel('P')
set(gca,'Yscale','log')
title(genotype)
legend(trackers)