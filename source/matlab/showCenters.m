%shows a image of the original shapes with centers overlaid on top
%offset moves each pixel by some amount (necessary due to cropping that removes edge effects)
function [] = showCenters(backgroundImage, centers, offset)
    figure;
    imagesc(backgroundImage);
    colormap(gray(256));
    hold on;
    [sx sy] = size(centers);
    if sy ~= 2
        [x y] = find(centers);
    else
        x = centers(:, 1);
        y = centers(:, 2);
    end
    plot(y + offset(2), x + offset(1),'.','color','red','MarkerSize',30);
    hold off;
    set(gcf, 'Position', get(0, 'ScreenSize'));
