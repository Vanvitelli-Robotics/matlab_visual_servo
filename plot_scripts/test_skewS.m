s = out.s.Data;
% s = rand(size(out.s.Data));
% s = [1 0 0 2 0 0 3 0 0; 1 0 0 2 0 0 3 0 5 ];

eigs = zeros(1,size(s,1));
eigsLL = zeros(1,size(s,1));

for i=1:size(s,1)
    si = s(i,:);
    SS = zeros(3,3);
    for j=0:(numel(si)/3-1)
        S = (skew(si(((3*j+1):(3*j+3)))));
        SS = SS - (S^2); 
    end
    eigs(:,i) = min(eig(SS));
    L = computeL(si);
    eigsLL(:,i) = min(svd(L'*L));
end

figure,plot(out.s.Time,eigs,out.s.Time,eigsLL)
% figure,plot(1:size(eigs,2),eigs)