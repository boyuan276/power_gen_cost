function smoothedGradient = gaussianGradient(segBids, price, h)
%GaussianCurve Summary of this function goes here
%   Detailed explanation goes here
numBids = size(segBids, 1);
smoothedGradient = 0;
for k=1:numBids
    qk = segBids(k, 1);
    pk = segBids(k, 2);
    smoothedGradient = smoothedGradient + qk/h * normpdf((price - pk)/h);
end
end
