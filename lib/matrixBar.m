function M = matrixBar(M, N)
%COMPUTEINTEGRALEXPSKEWBAR Summary of this function goes here
%   Detailed explanation goes here
M = kron(eye(N), M);
end

