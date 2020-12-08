function [cvx_y] = multiplot(data, para, num, kind)
%MULTIPLOT Calculate fitted data and plot them
%   Detailed explanation goes here
plotColumn = 4;
t = tiledlayout(numSelParts/plotColumn, plotColumn, "TileSpacing","compact");
cvx_y = cell(8, 1);
for i = 1:num
    % read original data
    x = data{i,1};
    y = data{i,2};
    par = para(i,:);
    % modify this each time
    if kind == 2
        cvx_y{i} = par(1)*x.^2+par(2)*x+par(3);
    elseif kind == 1
        cvx_y{i} = par(1)*x+par(2);
    elseif kind == 3    
        cvx_y{i} = par(1)*x.^3+par(2)*x.^2+par(3)*x+par(4);
    end
    
    % plot
    subplot(row,col,i);
    plot(x, y,'.', x, cvx_y{i});
    
end
xlabel(t, "Quantity (MWh)");
ylabel(t, "Marginal cost ($/MWh)");
title(t, "Quadratic fit of marginal cost model of selected market participants");
end



