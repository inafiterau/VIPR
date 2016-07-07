function [figHandles] = PlotClusteringData(X,Model)
%PLOTCLUSTERINGDATA Plot the data generated by GenerateClusteringData
% Plots the set of informative projections
    color = ['y','b','r','g','m','c'];
    figHandles = cell(size(Model.Projections,1),1);
    for i=1:size(Model.Projections,1)
        features = Model.Projections{i};
        if(length(features)<2)
            features = [features, features];
        end
        figHandles{i} = figure; hold on;
        xlim([0,length(Model.Projections)+1]);
        ylim([0,length(Model.Projections)+1]);
        xlabel(['Feature ',num2str(features(1))]);
        ylabel(['Feature ',num2str(features(2))]);
        if(length(features)==2)
            scatter(X(:,features(1)),X(:,features(2)),'.black');
            for j=1:size(Model.Clusters,2)
                idx = Model.Clusters{i,j}.index;
                xsub = X(idx,features);
                scatter(xsub(:,1),xsub(:,2),['.',color(mod(j,length(color))+1)]);
            end
        else
            zlim([0,length(Model.Projections)+1]);
            xlabel(['Feature ',num2str(features(1))]);
            zlabel(['Feature ',num2str(features(3))]);
            features = features(1:3);
            colrange = [0,size(Model.Clusters,2)+1];
            index = 1:size(X,1);
            for j=1:size(Model.Clusters,2)
                index = setdiff(index,Model.Clusters{i,j}.index);
            end
            plot3k(X(index,features),'ColorData',zeros(length(index),1),'ColorRange',colrange);
            for j=1:size(Model.Clusters,2)
                idx = Model.Clusters{i,j}.index;
                xsub = X(idx,features);
                plot3k(xsub,'ColorData',j*ones(size(xsub,1),1),'ColorRange',colrange);
            end
        end
        pause;
    end
end