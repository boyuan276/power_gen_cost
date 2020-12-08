function [cvx_y] = multiplot(data, para, num)
%MULTIPLOT Summary of this function goes here
%   Detailed explanation goes here
row = num/2;
col = 2;
fig = figure;
cvx_y = cell(8, 1);
for i = 1:num
    % read original data
    x = data{i,1};
    y = data{i,2};
    par = para(i,:);
    % modify this each time
%     cvx_y{i} = par(1)*x.^2+par(2)*x+par(3);
%     cvx_y{i} = par(1)*x+par(2);
    cvx_y{i} = par(1)*x.^3+par(2)*x.^2+par(3)*x+par(4);
    
    % plot
    subplot(row,col,i);
    plot(x, y,'.', x, cvx_y{i});
    
end
han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'"Marginal cost ($/MWh)"');
xlabel(han,'Quantity (MWh)');
title(han,'Marginal cost of top 20 market participants (CVX)');
end



