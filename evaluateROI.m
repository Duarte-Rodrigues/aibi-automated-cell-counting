% Function that returns the jaccard index, the maximum and the mean of the
% euclidean distances of a ROI image it recieves as input, comparing it
% with the ground truth.

function [jaccardIndex, euclideanMax, euclideanMean] = evaluateROI(ROI, i)
    % Name of the directiory of the masks.
    nameGroundTruthDir = 'test-images\test_ROI_images';
    groundTruthFolderInfo = dir(nameGroundTruthDir);
    
    % Get the mask of the corresponding index.
    nameGroundTruth = strcat(nameGroundTruthDir,'\',groundTruthFolderInfo(i).name);
    groundTruth = imread(nameGroundTruth);
    
    % Calculate the Jaccard index.
    jaccardIndex = round(jaccard(ROI, groundTruth),4);
    
    % Get ROI vertices.
    structBoundariesROI = bwboundaries(ROI);
    boundariesROI = structBoundariesROI{1};
    x = boundariesROI(:, 2); y = boundariesROI(:, 1);
    topLineROI = min(x); bottomLineROI = max(x);
    leftColumnROI = min(y); rightColumnROI = max(y);
    verticesROI = [topLineROI leftColumnROI; topLineROI rightColumnROI; bottomLineROI leftColumnROI; bottomLineROI rightColumnROI];
    
    % Get ground truth vertices.
    structBoundariesGT = bwboundaries(groundTruth);
    boundariesGT = structBoundariesGT{1};
    x = boundariesGT(:, 2); y = boundariesGT(:, 1);
    topLineGT = min(x); bottomLineGT = max(x);
    leftColumnGT = min(y); rightColumnGT = max(y);
    verticesGT = [topLineGT leftColumnGT; topLineGT rightColumnGT; bottomLineGT leftColumnGT; bottomLineGT rightColumnGT];
    
    % Calculate the Euclidean distances and its maximum and average values.
    euclidean = zeros(1,4);
    for i=1:4
        euclidean(i)  = sqrt((verticesROI(i,1) - verticesGT(i,1))^ 2 + (verticesROI(i,2) - verticesGT(i,2))^ 2);
    end
    euclideanMax = round(max(euclidean),4);
    euclideanMean = round(mean(euclidean),4);
end