function [finalCentersX, finalCentersY] = locateCenters(inputImage)
    %smooth the image using a gaussian filter
    gaussianFilter = fspecial('gaussian', [5, 5], 1.4);
    smoothedImage = imfilter(inputImage, gaussianFilter, 'replicate');

    %calculate the magnitude of the image gradient.
    [gradientX, gradientY] = gradient(double(smoothedImage));
    gradientImage = sqrt(gradientX .^ 2 + gradientY .^ 2);

    %performs a hough transform searching for circle with radii R and returns one image for each radius
    R = [6, 7, 8, 9, 10, 11, 12];
    houghImage = houghCircleGrayscale(gradientImage, R);
    [sr, sx, sy] = size(houghImage);

    %for each of the hough transform images(for each radius)
    logFilteredHoughImage = zeros(sr, sx, sy);
    finalFilteredHoughImage = zeros(sr, sx, sy);
    for r = 1:length(R)
        %filtered the hough transform with a laplacian of gaussian filter -- should emphasize peaks and de-emphasize non-peaks
        logFilteredHoughImage(r, :, :) = imfilter(houghImage(r, :, :), -fspecial('log', [7,7]), 'replicate');

        %smoothing the results -- should favor centers over random peaks with nothing around them
        finalFilteredHoughImage(r, :, :) = imfilter(logFilteredHoughImage(r, :, :), fspecial('gaussian', [5, 5], 1.4), 'replicate');
    end
    squeezedHoughImage = reshape(max(finalFilteredHoughImage), [sx, sy]);


    %remove edges due to undesirable edge effects from hough transform and filtering
    %record the offset so that center coordinates can be translated back into the original coord system
    finalHoughImage = squeezedHoughImage(3:end - 2, 3:end - 2);
    offset = [2, 2]
    
    %uses an adaptive thresholding algorithm based on a histogram of the houghImage to
    %determine the points that have the highest vote
    %specifically, it finds the 0.5% of the pixels that have the highest vote in the hough transform
    %with an adaptive threshold determined from a 45x45 (22*2 + 1) pixel box
    centers = adaptiveThreshold(finalHoughImage, 22, 99.5);

    %builds an image where non-centers have value 0 and centers have a value equal to their hough vote
    centersHoughImage = zeros(size(centers));
    centersHoughImage(find(centers)) = finalHoughImage(find(centers)); 

    %requires that, in order to be a center, a pixel must be maximal in its 41x41 neighborhood.
    newCenters = findMaximalCentersNeighborhood(centersHoughImage, 20);

    %only return the coordinates of the centers
    [x y] = find(newCenters);
    
    %translate coordinates back into original coordinate system
    finalCentersX = x + offset(1);
    finalCentersY = y + offset(2);
    

