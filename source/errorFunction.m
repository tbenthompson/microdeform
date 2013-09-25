%needs xCorrMatrices and locations loaded already
function F = errorFunction(displace, xCorrMatrices, nearestIndices, nearestDistances, nearestCount, distanceFactor)
    disp('eval');
    target = 101 + round(displace);

    [xCorrDim1 xCorrDim2 xCorrDim3] = size(xCorrMatrices);
    firstIndex = 1:xCorrDim1;
    sub1 = target(1, :);
    sub2 = target(2, :);
    indices = sub2ind([xCorrDim1, xCorrDim2, xCorrDim3], firstIndex, sub1, sub2);

    newCorrels = xCorrMatrices(indices);

    distancePenalty = zeros(nearestCount * xCorrDim1 * 2, 1);
    %vectorize this
    for i = firstIndex
        for j =             
            if nearestDistances(i,j) == 0
                continue
            end
            displacementDist = (displace(:, nearestIndices(i, j)) - displace(:, i)) / nearestDistances(i,j);
            distancePenalty(sub2ind([xCorrDim1, nearestCount, 2], i, j - 1, 1)) = displacementDist(1);
            distancePenalty(sub2ind([xCorrDim1, nearestCount, 2], i, j - 1, 2)) = displacementDist(2);
        end
    end
    distancePenalty = distancePenalty * distanceFactor;

    %negative for the correlations because higher correlations are better 
    F = [distancePenalty; -newCorrels'];
