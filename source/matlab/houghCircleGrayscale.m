%performs the circular hough transform on a grayscale gradient image (black = less of a vote, white = more of a vote, linear scale)
%for each radius provided (R), returns one array with the same size as the input image (im)
%the array represents the hough transform vote for each pixel in the input image
function [out_im] = houghCircleGrayscale(im, R)
    [sizeY,sizeX] = size(im);
    houghMat = zeros(length(R), sizeY, sizeX);
    R2 = R .^ 2;
    for i = 1:sizeY
        for j = 1:sizeX
            for k = 1:length(R)
                b = max(1, i - R(k)):min(i + R(k), sizeY);
                xMinusASquared = sqrt(R2(k) - (i - b).^2);
                aLeft = max(1, round(j - xMinusASquared));
                aRight = min(round(j + xMinusASquared), sizeX);
                for l = 1:length(aLeft)
                    if imag(aLeft(l))==0 & aLeft(l)>0
                        houghMat(k, b(l), aLeft(l)) = houghMat(k, b(l), aLeft(l)) + im(i, j);
                    end
                    if imag(aRight(l))==0 & aRight(l)>0
                        houghMat(k, b(l), aRight(l)) = houghMat(k, b(l), aRight(l)) + im(i, j);
                    end
                end
            end
        end
        display(i / sizeY * 100)
    end
    if length(R) > 1
        out_im = houghMat;	
    else
        out_im = reshape(houghMat, [sizeY, sizeX]);
    end;
