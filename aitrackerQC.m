clear
close all

trackers = {'AI','TT'};
genotypes = {'npr1','N2'};
featureName = 'selectedTraj'; %'longestTracks'; %'trackLength';
featureFig = figure;
loadResults = false;
saveResults = false;
addpath('../AggScreening/auxiliary/')

exportOptions = struct('Format','eps2',...
    'Color','rgb',...
    'Width',30,...
    'Resolution',300,...
    'FontMode','fixed',...
    'FontSize',25,...
    'LineWidth',3);

% go through tracker type
for trackerCtr = 1:length(trackers)
    tracker = trackers{trackerCtr};
    % go through genotype
    for genotypeCtr = 1:length(genotypes)
        genotype = genotypes{genotypeCtr};
        % check to see if feature has already been calculated and load
        if loadResults
            if exist([genotype tracker featureName '.mat'])
                load([genotype tracker featureName '.mat'],featureName,'wormIDs')
            end
        else % calculate results
            if strcmp(featureName,'trackLength')
                % calculate track length
                [trackLength,wormIDs] = getTrackLength(tracker, genotype);
            elseif strcmp(featureName,'longestTracks')
                % get xy coordinates for 10 longest tracks
                [longestTracks,wormIDs] = getLongestTracks(genotype, tracker);
            elseif strcmp(featureName,'selectedTraj')
                [selectedTraj,wormIDs] = getSelectedTraj(genotype, tracker);
            else
                warning('feature does not exist')
            end
            % save
            if saveResults
                savename = [genotype tracker featureName '.mat'];
                save(savename,featureName,'wormIDs')
            end
        end
        % update file counter
        fileCtr = (trackerCtr-1)*numel(trackers)+genotypeCtr;
        if strcmp(featureName, 'trackLength')
            plotTrackLength(trackLength,featureFig,trackers,genotypes,tracker,genotype,fileCtr);
        elseif strcmp(featureName,'longestTracks')
            plotLongestTracks(longestTracks,featureFig,trackers,genotypes,tracker,genotype,fileCtr,wormIDs);
        elseif strcmp(featureName,'selectedTraj')
            plotSelectedTraj(selectedTraj,featureFig,trackers,genotypes,tracker,genotype,fileCtr,wormIDs);
        end
    end
end
% export figure
figurename = ['results/' featureName];
if saveResults
    exportfig(featureFig,[figurename '.eps'],exportOptions)
end