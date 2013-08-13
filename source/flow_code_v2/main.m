addpath('flow_code_v2');
im1 = imread('../../data/bdcropped2.png');
im2 = imread('../../data/adcropped2.png');
gaussianFilter = fspecial('gaussian', [5, 5], 1.4);
smoothedImage = imfilter(im1, gaussianFilter, 'replicate');
%calculate the magnitude of the image gradient.
[gradientX, gradientY] = gradient(double(smoothedImage));
im1GradientMag = sqrt(gradientX .^ 2 + gradientY .^ 2);
gaussianFilter = fspecial('gaussian', [5, 5], 1.4);
smoothedImage = imfilter(im2, gaussianFilter, 'replicate');
%calculate the magnitude of the image gradient.
[gradientX, gradientY] = gradient(double(smoothedImage));
im2GradientMag = sqrt(gradientX .^ 2 + gradientY .^ 2);




uv = estimate_flow_interface(im1GradientMag, im2GradientMag);
