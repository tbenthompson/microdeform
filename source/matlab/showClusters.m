function [] = showClusters(mdData, k, which)
    colors = lines(k);
    figure;
    imagesc(mdData(which).image);
    colormap(gray(256));
    hold on;
    for i = 1:length(mdData(which).preservedCentersX)
        plot(mdData(which).preservedCentersY(i), mdData(which).preservedCentersX(i),'.','color',colors(mdData(which).clusterIndices(i), :),'MarkerSize',30);  
    end
    hold off;
