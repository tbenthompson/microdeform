%simple percentile based adaptive thresholding algorithm. returns all the pixels that are above a certain percentile in brightness
%for example, percentile = 95 would return 5% of the pixels with  the highest intensity
function [out_im]=adaptiveThreshold(im, ws, percentile)
    [sx, sy] = size(im);
    totalPixelsPerWindow = (ws + 1) ^ 2;
    pixelsToTakePerWindow = round((100 - percentile) / 100 * totalPixelsPerWindow);
    out_im = zeros(sx, sy);
    for i = 1:sx
        for j = 1:sy
            pixelValue = im(i, j);
            imageChunk = im(max(1, i - ws):min(i + ws, sx), max(1, j - ws):min(j + ws, sy));
            numBrighterPixels = length(find(imageChunk > pixelValue));
            if numBrighterPixels < pixelsToTakePerWindow
                out_im(i,j) = 1;
            end
        end
        if mod(i, int8(sx / 100)) == 0
            display(i / sx * 100);
        end
    end
