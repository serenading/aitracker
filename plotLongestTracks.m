function plotLongestTracks(longestTracks,featureFig,trackers,genotypes,tracker,genotype,fileCtr,wormIDs)

set(0,'CurrentFigure',featureFig)
subplot(numel(trackers),numel(genotypes),fileCtr)
hold on
for wormCtr = 1:numel(wormIDs)
    plot(longestTracks{wormCtr}(:,1),longestTracks{wormCtr}(:,2))
end
axis equal
xlim([0 2500])
ylim([0 2500])
title([genotype '_' tracker],'Interpreter','None')
