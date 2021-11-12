function intSbar = computeIntegralExpSkewBar(lambdaT,w, N_features)
%COMPUTEINTEGRALEXPSKEWBAR Summary of this function goes here
%   Detailed explanation goes here
intSbar = kron(eye(N_features), computeIntegralExpSkew(lambdaT,w(1),w(2),w(3)));
end

