%intended to find centers for circles using the data from the circular hough transform
function [out_im] = findMaximalCentersNeighborhood(im, d)
    [sx, sy] = size(im);
    out_im = zeros(sx, sy);
    for i = 1:sx
        for j = 1:sy
            imageChunk = im(max(1, i - d):min(i + d, sx), max(1, j - d):min(j + d, sy));
            if max(max(imageChunk)) == im(i, j) & im(i, j) ~= 0
                out_im(i, j) = 1;
            end
        end
    end
