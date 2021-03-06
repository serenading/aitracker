function [selectedTraj,wormIDs] = getSelectedTraj(genotype,tracker)

% set parameters
timeWindow = [30, 35]; % start and end time in minutes
frameRate = 9;

% get list of frames
frames = timeWindow*60*frameRate;
frames = frames(1):frames(2);

% initialise
numCols = 4;
selectedTraj = NaN(100000,numCols);

% get selectedTraj for the time window
if strcmp(tracker,'AI')
    if strcmp(genotype,'npr1')
        filename = '/Volumes/behavgenom$/Serena/aitracker/51.2g_rescaledFull.tif.csv';
    elseif strcmp(genotype,'N2')
        filename = '/Volumes/behavgenom$/Serena/aitracker/51.3g_rescaledFull.tif.csv';
    end
    output = readtable(filename);
    % get valid frame indices
    frameInd = [];
    for frameCtr = 1:numel(frames)
        frame = frames(frameCtr);
        frameInd = vertcat(frameInd,find(output.t == frame)); % indices for all specified frames
    end
    % get trajectories for all worms during the specified window
    wormIDs = unique(output.particle(frameInd));
    rowStartIdx = 1;
    for wormCtr = 1:numel(wormIDs)
        worm = wormIDs(wormCtr);
        wormInd = find(output.particle == worm);
        validRowInd = intersect(frameInd,wormInd);
        rowsToAdd = numel(validRowInd);
        rowEndIdx = rowStartIdx+rowsToAdd-1;
        selectedTraj(rowStartIdx:rowEndIdx,1) = ones(numel(validRowInd),1)*worm;
        selectedTraj(rowStartIdx:rowEndIdx,2) = output.x(validRowInd);
        selectedTraj(rowStartIdx:rowEndIdx,3) = output.y(validRowInd);
        selectedTraj(rowStartIdx:rowEndIdx,4) = output.t(validRowInd);
        rowStartIdx = rowEndIdx+1;
        if rowEndIdx > size(selectedTraj,1)
            warning('Not enough rows pre-allocated')
        end
    end
elseif strcmp(tracker,'TT')
    if strcmp(genotype,'npr1')
        filename = '/Volumes/behavgenom$/Serena/fluorescenceTwoColourData/Results/recording51/recording51.2g100-250/recording51.2g_X1_skeletons.hdf5';
    elseif strcmp(genotype,'N2')
        filename = '/Volumes/behavgenom$/Serena/fluorescenceTwoColourData/Results/recording51/recording51.3g100-250/recording51.3g_X1_skeletons.hdf5';
    end
    trajData = h5read(filename,'/trajectories_data');
    % get valid frame indices
    frameInd = [];
    wormIDs = [];
    for frameCtr = 1:numel(frames)
        frame = frames(frameCtr);
        frameInd = vertcat(frameInd,find(trajData.frame_number == frame)); % indices for all specified frames
        wormIDs = vertcat(wormIDs, trajData.worm_index_joined(frameInd)); % wormID's during all specified frames
    end
    % get selected trajectories
    wormIDs = unique(wormIDs);
    rowStartIdx = 1;
    for wormCtr = 1:numel(wormIDs)
        worm = wormIDs(wormCtr);
        wormInd = find(trajData.worm_index_joined == worm);
        validRowInd = intersect(frameInd,wormInd);
        rowsToAdd = numel(validRowInd);
        rowEndIdx = rowStartIdx+rowsToAdd-1;
        selectedTraj(rowStartIdx:rowEndIdx,1) = ones(numel(validRowInd),1)*double(worm);
        selectedTraj(rowStartIdx:rowEndIdx,2) = trajData.coord_y(validRowInd);
        selectedTraj(rowStartIdx:rowEndIdx,3) = trajData.coord_x(validRowInd);
        selectedTraj(rowStartIdx:rowEndIdx,4) = trajData.frame_number(validRowInd);
        rowStartIdx = rowEndIdx+1;
        if rowEndIdx > size(selectedTraj,1)
            warning('Not enough rows pre-allocated')
        end
    end
end

% remove empty NaN's
selectedTraj = selectedTraj(~isnan(selectedTraj));
selectedTraj = reshape(selectedTraj,[numel(selectedTraj)/numCols,numCols]);