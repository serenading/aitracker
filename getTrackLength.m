function [trackLength,wormIDs] = getTrackLength(tracker, genotype)

if strcmp(tracker,'AI')
    if strcmp(genotype,'npr1')
        filename = '/Volumes/behavgenom$/Serena/aitracker/51.2g_rescaledFull.tif.csv';
    elseif strcmp(genotype,'N2')
        filename = '/Volumes/behavgenom$/Serena/aitracker/51.3g_rescaledFull.tif.csv';
    end
    output = readtable(filename);
    wormIDs = unique(output.particle);
    nWorms = numel(wormIDs);
    trackLength = NaN(nWorms,2);
    for wormIDCtr = 1:nWorms
        disp(wormIDCtr/nWorms)
        uniqueWormID = wormIDs(wormIDCtr);
        trackLength(wormIDCtr,1) = uniqueWormID;
        trackLength(wormIDCtr,2) = numel(find(output.particle == uniqueWormID));
    end
elseif strcmp(tracker,'TT')
    if strcmp(genotype,'npr1')
        filename = '/Volumes/behavgenom$/Serena/fluorescenceTwoColourData/Results/recording51/recording51.2g100-250/recording51.2g_X1_skeletons.hdf5';
    elseif strcmp(genotype,'N2')
        filename = '/Volumes/behavgenom$/Serena/fluorescenceTwoColourData/Results/recording51/recording51.3g100-250/recording51.3g_X1_skeletons.hdf5';
    end
    trajData = h5read(filename,'/trajectories_data');
    wormIDs = unique(trajData.worm_index_joined);
    nWorms = numel(wormIDs);
    trackLength = NaN(nWorms,2);
    for wormIDCtr = 1:nWorms
        disp(wormIDCtr/nWorms)
        uniqueWormID = wormIDs(wormIDCtr);
        trackLength(wormIDCtr,1) = uniqueWormID;
        trackLength(wormIDCtr,2) = numel(find(trajData.worm_index_joined == uniqueWormID));
    end
end