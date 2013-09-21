load('../data/CM14_fft.mat');
inputImageBD = imrotate(CM14_fft(1).gridbd, -0.8);
inputImageAD = imrotate(CM14_fft(1).gridad, -0.8);

gaussianFilter = fspecial('gaussian', [5, 5], 1.4);
smoothedImageBD = imfilter(inputImageBD, gaussianFilter, 'replicate');
evenMagImageBD = histeq(smoothedImageBD); %correct light magnitude -- naive

%calculate the magnitude of the image gradient.
disp('finding gradient');
[gradientXBD, gradientYBD] = gradient(double(evenMagImageBD));
gradientImageBD = sqrt(gradientXBD .^ 2 + gradientYBD .^ 2);
figure; imagesc(gradientImageBD); colormap(gray(256));


smoothedImageAD = imfilter(inputImageAD, gaussianFilter, 'replicate');
evenMagImageAD = histeq(smoothedImageAD);

disp('finding gradient');
[gradientXAD, gradientYAD] = gradient(double(evenMagImageAD));
gradientImageAD = sqrt(gradientXAD .^ 2 + gradientYAD .^ 2);
figure; imagesc(gradientImageAD); colormap(gray(256));


