load('../data/CM14_fft.mat');
inputImage = imrotate(CM14_fft(1).gridbd(100:500, 100:500), -0.8);
inputImage2 = imrotate(CM14_fft(1).gridad(100:500, 100:500), -0.8);
% ffht = newCode2(inputImage)
% ffht2 = newCode2(inputImage2)


gaussianFilter = fspecial('gaussian', [5, 5], 1.4);
smoothedImage = imfilter(CM14_fft(1).gridbd, gaussianFilter, 'replicate');

%calculate the magnitude of the image gradient.
disp('finding gradient');
[gradientX, gradientY] = gradient(double(smoothedImage));
gradientImageBD = sqrt(gradientX .^ 2 + gradientY .^ 2);


gaussianFilter = fspecial('gaussian', [5, 5], 1.4);
smoothedImage = imfilter(CM14_fft(1).gridad, gaussianFilter, 'replicate');

%calculate the magnitude of the image gradient.
disp('finding gradient');
[gradientX, gradientY] = gradient(double(smoothedImage));
gradientImageAD = sqrt(gradientX .^ 2 + gradientY .^ 2);


F = fftshift(fft2(gradientImageBD)); % Center FFT

F = abs(F); % Get the magnitude
F = log(F+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1

figure; imshow(F,[]); % Display the result

figure;
for i=1:8
	for j=1:8
		chunk = gradientImageAD((100+i*50):(150+i*50),(100+j*50):(150+j*50));
		F = fftshift(fft2(chunk)); % Center FFT	

		F = abs(F); % Get the magnitude
		F = log(F+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
		F = mat2gray(F); % Use mat2gray to scale the image between 0 and 1
		
		subplot(8,8,(i-1)*8 + j)
		imshow(F,[]); % Display the result
	end
end




