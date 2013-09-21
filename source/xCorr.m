addpath('./correlCorresp/');
% a = gradientImageBD(500:1500,500:1500);
% b = gradientImageAD(500:1500,500:1500);
a = evenMagImageBD(400:700, 800:1100);
b = evenMagImageAD(400:700, 800:1100);

% c = normxcorr2(a,b);
% figure; imagesc(a); colormap(gray(256));
% figure; imagesc(b); colormap(gray(256));
% figure, surf(c), shading flat;
% [v,ind]=max(c);
% [v1,ind1]=max(max(c));
% disp(['The largest element in X is' num2str(v1) ' at (' num2str(ind(ind1)) ',' num2str(ind1) ')']);


a = double(a);
b = double(b);

cc = correlCorresp('image1', a, 'image2', b, 'printProgress', 100, 'convTol', 0.01);
cc = cc.findCorresps;
correspDisplay(cc.corresps, a);
figure;imagesc(b);colormap(gray(256));
directionx = cc.corresps(3,:) - cc.corresps(1,:);
directiony = cc.corresps(4,:) - cc.corresps(2,:);
figure;plot(directionx, directiony, '.')
save('../data/correspsNice.mat', 'cc');
