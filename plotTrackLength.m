function plotTrackLength(trackLength,featureFig,trackers,genotypes,tracker,genotype,fileCtr)

% get track length info
trackLength = trackLength(:,2);
% ignore tracks that last <9 frames (1s)
trackLength = trackLength(trackLength>9);
set(0,'CurrentFigure',featureFig)
% plot distribution
subplot(numel(trackers),numel(genotypes),fileCtr)
histogram(trackLength,'BinWidth',9,'Normalization','Probability')
xlim([0 1000])
xlabel('frames')
ylabel('P')
title([genotype '_' tracker],'Interpreter','None')
set(gca,'Yscale','log')