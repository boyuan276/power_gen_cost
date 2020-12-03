function smoothedBids = gaussianCurve(segBids, pMin, pMax, h)
%GaussianCurve Summary of this function goes here
%   Detailed explanation goes here
numBids = size(segBids, 1);
price = [pMin:pMax]';
supply = zeros(size(price));
for i=1:size(price, 1)  
    for k=1:numBids
        qk = segBids(k, 1);
        pk = segBids(k, 2);
        supply(i) = supply(i) + qk * normcdf((price(i) - pk)/h);
    end
end
smoothedBids = [supply, price];
end

