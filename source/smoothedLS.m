load('../data/correspsNiceSavedReduced.mat');
runs = 4;
nearestCount = 2;
distanceFactor = [0.0001, 0.001, 0.01, 0.1];

%get nearest neighbors
locations = [cc.corresps(1, :); cc.corresps(3, :)];
%knnsearch finds nearest nearest neighbors -- it requires the input to have individual observations as rows, so i take the transpose
[nearestIndices, nearestDistances] = knnsearch(locations', locations', 'K', nearestCount + 1);

xCorrMatrices = cc.xCorrMatrices;
[a, b] = size(locations);
displacement = zeros(runs, a, b);
[cc.corresps(4,:) - cc.corresps(2,:); cc.corresps(3,:) - cc.corresps(1,:)];

startDisplacement = reshape([cc.corresps(4,:) - cc.corresps(2,:); cc.corresps(3,:) - cc.corresps(1,:)], [a, b]);

% matlabpool open local 4;
% parfor i=1:runs
for i=1:runs
    f = @(x) errorFunction(x, xCorrMatrices, nearestIndices, nearestDistances, nearestCount, distanceFactor(i));
    displacement(i, :, :) = lsqnonlin(f, startDisplacement, repmat(-100, size(startDisplacement)), repmat(100, size(startDisplacement)));
end
% matlabpool close;
