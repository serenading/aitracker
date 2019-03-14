function plotSelectedTraj(selectedTraj,featureFig,trackers,genotypes,tracker,genotype,fileCtr,wormIDs)

set(0,'CurrentFigure',featureFig)
all_x = selectedTraj(:,2);
all_y = selectedTraj(:,3);
for wormCtr = 1:numel(wormIDs)
    worm = wormIDs(wormCtr);
    rowInd = find(selectedTraj(:,1) == worm);
    subplot(numel(trackers),numel(genotypes),fileCtr)
    hold on
    plot(all_x(rowInd), all_y(rowInd))
end
axis equal
xlim([0 2500])
ylim([0 2500])
title([genotype '_' tracker],'Interpreter','None')