function Lpinv = computeLpinv(s, preloadL)
%COMPUTEL Summary of this function goes here
%   Detailed explanation goes here

if(nargin < 2)
   preloadL = true; 
end

Lpinv = pinv(computeL(s,preloadL));

end