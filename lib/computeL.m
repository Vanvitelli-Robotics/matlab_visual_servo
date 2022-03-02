function L = computeL(s, preloadL)
%COMPUTEL compute the interaction matrxi
%   s: features
%   preloadL: internal use, for code generation

if(nargin < 2)
   preloadL = true; 
end

s = s(:);

if(preloadL)
L = zeros(numel(s),6);
end

for i=1:(numel(s)/3)
   indx = (3*(i-1)+1):(3*(i-1)+3);
   L(indx, :) =  [-eye(3), skew(s( indx ))];
end

end

