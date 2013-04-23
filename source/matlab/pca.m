function [outData] = pca(inData)
    allData = [];
    set = 1:12;
    set = 1:1;
    for i = set
        [sn sx sy] = size(inData(i).centerImages);
        pcaReadyImages = reshape(inData(i).centerImages, [sn, sx * sy]);
        allData = vertcat(allData, pcaReadyImages);
    end   
    [pc,score,latent,tsquare] = princomp(allData); 
    inData(1).eigenvalues = latent;
    startIndex = 1;
    for i = set
        endIndex = startIndex - 1 + length(inData(i).centerImages);
        inData(i).pcaData = score(startIndex:endIndex, :);
        startIndex = endIndex + 1;
    end
    outData = inData;



