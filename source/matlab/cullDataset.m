%allows manual culling of the centers -- occurs in a non-linear fashion such that it doesn't have to all be done at once.
function [outData] = cullDataset(inData, maxIndex)
    for i = 1:maxIndex
        if length(inData(i).preservedCentersX) <= 1
            inData(i).preservedCentersX = inData(i).centersX;
            inData(i).preservedCentersY = inData(i).centersY;
        end
        culledCount = length(inData(i).culledCentersX) + 1;
        while true
            imagesc(inData(i).image);
            colormap(gray(256));
            hold on;
            plot(inData(i).preservedCentersY, inData(i).preservedCentersX,'.','color','red','MarkerSize',16);
            hold off;
            set(gcf, 'Position', get(0, 'ScreenSize'));
            [cullY cullX] = ginput();
            close;
            if length(cullX) == 0
                break;
            end
            for j = 1:length(cullX)
                [dist, closest] = min((inData(i).centersX - cullX(j)) .^ 2 + (inData(i).centersY - cullY(j)) .^ 2);
                if dist > 81
                    continue;
                end;
                inData(i).culledCentersX(culledCount) = inData(i).centersX(closest);
                inData(i).culledCentersY(culledCount) = inData(i).centersY(closest);
                culledCount = culledCount + 1;
            end
            preservedCenters = setdiff([inData(i).centersX inData(i).centersY], [inData(i).culledCentersX' inData(i).culledCentersY'], 'rows');
            inData(i).preservedCentersX = preservedCenters(:, 1);
            inData(i).preservedCentersY = preservedCenters(:, 2);
        end
    end
    outData = inData;
