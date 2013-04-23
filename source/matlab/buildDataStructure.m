%allImageCenters gathers all the centers and saves them
load('../data/CM14_fft.mat');

new = false;

md_data = struct;
if new == true
    data_title = datestr(now, 'mm_dd_yyyy_hh_MM_ss');
    md_data.note = 'write info about data here';
else
    data_title = '10_10_2011_23_20_11';
    load(strcat('../data/', data_title,'.mat'));
end

for i = 1:12
%    md_data(i).image = imrotate(CM14_fft(i).gridbd, -0.8);
%    [x y] = locateCenters(md_data(i).image);
%    md_data(i).centersX = x;
%    md_data(i).centersY = y;
    md_data(i).preservedCentersX = zeros(1);
    md_data(i).preservedCentersY = zeros(1);
    md_data(i).culledCentersX = zeros(1);
    md_data(i).culledCentersY = zeros(1);
end
%md_data = cullDataset(md_data);
%md_data = buildImageSectionDataset(md_data);
md_data = pca(md_data);
md_data = kMeansClustering(md_data, 5, 7);
showClusters(md_data, 7, 1);

%save(strcat('../data/', data_title,'.mat'), 'md_data');

