function Lpinv = computeLpinv(s, preloadL)
%COMPUTEL interaction matrix pseudoinverse

if(nargin < 2)
   preloadL = true; 
end

Lpinv = pinv(computeL(s,preloadL));

end