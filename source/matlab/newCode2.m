function [finalFilteredHoughImage] = newCode2(inputImage)
%smooth the image using a gaussian filter
disp('smoothing image');
gaussianFilter = fspecial('gaussian', [5, 5], 1.4);
smoothedImage = imfilter(inputImage, gaussianFilter, 'replicate');

%calculate the magnitude of the image gradient.
disp('finding gradient');
[gradientX, gradientY] = gradient(double(smoothedImage));
gradientImage = sqrt(gradientX .^ 2 + gradientY .^ 2);

%performs a hough transform searching for circle with radii R and returns one image for each radius
disp('hough transform');
R = [6, 7, 8, 9, 10, 11, 12];
houghImage = houghCircleGrayscale(gradientImage, R);
[sr, sx, sy] = size(houghImage);

%for each of the hough transform images(for each radius)
disp('filtering hough transform')
logFilteredHoughImage = zeros(sr, sx, sy);
finalFilteredHoughImage = zeros(sr, sx, sy);
for r = 1:length(R)
	%filtered the hough transform with a laplacian of gaussian filter -- should emphasize peaks and de-emphasize non-peaks
	logFilteredHoughImage(r, :, :) = imfilter(houghImage(r, :, :), -fspecial('log', [7,7]), 'replicate');

	%smoothing the results -- should favor centers over random peaks with nothing around them
	finalFilteredHoughImage(r, :, :) = imfilter(logFilteredHoughImage(r, :, :), fspecial('gaussian', [7, 7], 1.4), 'replicate');
end
