init

Leq = computeL(s_eq3);

% s0 = s_eq3(:) + ((eye(numel(s_eq3)) - Leq*pinv(Leq))*(-.001*rand(numel(s_eq3),1)));
% s0 = s0 + Leq*pinv(Leq)*(+.001*rand(numel(s_eq3),1));

s_star = C_features_desired;
[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(s_star);

Lsstar = computeL(s_star);

% 1
shat = s_eq3;
Lseq = computeL(shat);
U = -Lseq*inv(Lseq'*Lseq)*(Lsstar');
[V,D] = eig(U);
D = diag(D);
idx = find(D>eps,1);
idx=9;

C = [];
for i=1:N
    for j=1:N
       if i==j
          continue; 
       end
       si_star = s_star(:,i);
       si_hat = shat(:,i);
       sj_star = s_star(:,j);
       sj_hat = shat(:,j);
       u0 = si_star - sj_star + si_hat - sj_hat;
       c0 = zeros(3,N);
       c0(:,i) = -u0;
       c0(:,j) = u0;
       C(:,end+1) = c0(:);
%        (V'*c0(:) / norm(c0(:)))'
    end 
end

% slin_0 = 0.001*V(:,idx);
% slin_0 = 0.001*C(:,2);
% s0 = slin_0 + shat(:);

slin_0 = s0 - shat(:);



% slin_0 = s0(:) - shat(:);
