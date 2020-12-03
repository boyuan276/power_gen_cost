function smoothedGradient = gaussianGradient(segBids, pMin, pMax, h)
%GaussianCurve Summary of this function goes here
%   Detailed explanation goes here
numBids = size(segBids, 1);
price = [pMin:pMax]';
gradient = zeros(size(price));
for i=1:size(price, 1)  
    sum = 0;
    for k=1:numBids
        qk = segBids(k, 1);
        pk = segBids(k, 2);
        sum = sum + qk/h * normpdf((price(i) - pk)/h);
    end
    gradient(i) = sum;
end
smoothedGradient = [gradient, price];
end
