load('../data/CM14_fft.mat');

image1 = CM14_fft(1).gridbd;
[x y] = locateCenters(image1);
centermap1 = zeros(size(image1));
centermap1(x,y) = 1;

image2 = imrotate(CM14_fft(1).gridbd, -20);
imagesc(image2);
[x2 y2] = locateCenters(image2);
centermap2 = zeros(size(image2));
centermap2(x2,y2) = 1;
original_coords_centermap2 = imrotate(centermap2, 20)

d = 3;
[sx sy] = size(image1);
fail = 0;
for i = 1:length(x)
    chunk = original_coords_centermap2(max(1, x(i) - d):min(x(i) + d, sx), max(1, y(i) - d):min(y(i) + d, sy));
    if sum(sum(chunk)) == 1
        fail = fail + 1;
        display('a fail!');
    else
        display('a not fail!'); 
    end
end
