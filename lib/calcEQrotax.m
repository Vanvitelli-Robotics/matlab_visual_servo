function [rotax] = calcEQrotax(C_features, indx)

b = sum(C_features,2)/size(C_features,2);

M = zeros(3,3);

for i = 1:size(C_features,2)
   
    M = M + (C_features(:,i)*C_features(:,i)');
    
end

M = M - size(C_features,2)*(b*b');

[V,~] = eig(M);
rotax = unit(V(:,indx));

end

