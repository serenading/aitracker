function plotTrackLength(trackLength,featureFig,legends)

% get track length info
trackLength = trackLength(:,2);
% ignore tracks that last <9 frames (1s)
trackLength = trackLength(trackLength>9);
set(0,'CurrentFigure',featureFig) 
hold on
% plot distribution
histogram(trackLength,'BinWidth',9,'Normalization','Probability','DisplayStyle','Stairs')
xlim([0 1000])
xlabel('frames')
ylabel('P')
set(gca,'Yscale','log')
legend(legends)