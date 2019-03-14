function [longestTracks,wormIDs] = getLongestTracks(genotype, tracker)

numTracks = 5;

% if calculation has been made, simply load
if exist([genotype tracker 'trackLength.mat'])
    load([genotype tracker 'trackLength.mat'],'trackLength')
else
    trackLength = getTrackLength(tracker, genotype);
end

% sort track length by descending trackLength
trackLength = sortrows(trackLength,2,'descend');
% get wormID for the ten longest tracks
wormIDs =  trackLength(1:numTracks,1);
% pre-allocate for worm traj
longestTracks = cell(1,numTracks);
% load file
if strcmp(tracker,'AI')
    if strcmp(genotype,'npr1')
        filename = '/Volumes/behavgenom$/Serena/aitracker/51.2g_rescaledFull.tif.csv';
    elseif strcmp(genotype,'N2')
        filename = '/Volumes/behavgenom$/Serena/aitracker/51.3g_rescaledFull.tif.csv';
    end
    output = readtable(filename);
    for wormCtr = 1:numel(wormIDs)
        wormID = wormIDs(wormCtr);
        wormIDRowInd = find(output.particle == wormID);
        longestTracks{wormCtr} = NaN(numel(wormIDRowInd),2);
        longestTracks{wormCtr}(:,1) = output.x(wormIDRowInd);
        longestTracks{wormCtr}(:,2) = output.y(wormIDRowInd);
    end
elseif strcmp(tracker,'TT')
    if strcmp(genotype,'npr1')
        filename = '/Volumes/behavgenom$/Serena/fluorescenceTwoColourData/Results/recording51/recording51.2g100-250/recording51.2g_X1_skeletons.hdf5';
    elseif strcmp(genotype,'N2')
        filename = '/Volumes/behavgenom$/Serena/fluorescenceTwoColourData/Results/recording51/recording51.3g100-250/recording51.3g_X1_skeletons.hdf5';
    end
    trajData = h5read(filename,'/trajectories_data');
    for wormCtr = 1:numel(wormIDs)
        wormID = wormIDs(wormCtr);
        wormIDRowInd = find(trajData.worm_index_joined == wormID);
        longestTracks{wormCtr} = NaN(numel(wormIDRowInd),2);
        longestTracks{wormCtr}(:,1) = trajData.coord_y(wormIDRowInd);
        longestTracks{wormCtr}(:,2) = trajData.coord_x(wormIDRowInd);
    end
end