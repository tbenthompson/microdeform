%takes a chunk of image surrounding each center and compiles them into a dataset
function [outData] = buildImageSectionDataset(inData)
    for i = 1:1
        %add a black border to the edges of the image -- so that all the centers are far enough in the center of the image
        [sx sy] = size(inData(i).image);
        borderedImage = zeros(sx + 100, sy + 100);
        borderedImage(51:end - 50, 51:end - 50) = inData(i).image;
        images = zeros(length(inData(i).preservedCentersX), 37, 37);
        for j = 1:length(inData(i).preservedCentersX)
            x = inData(i).preservedCentersX(j);
            y = inData(i).preservedCentersY(j);
            imageChunk = borderedImage((x + 50) - 18:(x + 50) + 18, (y + 50) - 18:(y + 50) + 18);
            images(j, :, :) = imageChunk;
            display((i/12));
            display((j/length(inData(i).preservedCentersX)));
        end
        inData(i).centerImages = images;
    end
    outData = inData;
