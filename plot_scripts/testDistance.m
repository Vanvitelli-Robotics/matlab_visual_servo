stest = e(1,:)' + s_star(:);
stest = reshape(stest,3,numel(stest)/3);

N = numel(stest)/3;
for i=1:N
   for j=1:N
       sstari = s_star(:,i);
       stesti = stest(:,i);
       sstarj = s_star(:,j);
       stestj = stest(:,j);
       norm(sstari-sstarj)-norm(stesti-stestj)
   end
end
