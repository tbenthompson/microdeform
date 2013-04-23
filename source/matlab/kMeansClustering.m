function [outData] = kMeansClustering(inData, vars, k);
    allData = [];
    set = 1:12;
    set = 1:1;
    for i = set
        allData = vertcat(allData, inData(i).pcaData(:, 1:vars));
    end
    groupIndices = kmeans(allData, k);
    startIndex = 1;
    for i = set
        endIndex = startIndex - 1 + length(inData(i).pcaData(:, 1:vars));
        inData(i).clusterIndices = groupIndices(startIndex:endIndex);
        startIndex = endIndex + 1;
    end
    outData = inData;


