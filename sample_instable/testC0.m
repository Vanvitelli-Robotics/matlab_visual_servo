% clear all
% close all

addpath('../lib')

% s_star = sstar;
N = numel(s_star)/3;

norm_sstar = 1; %dim

% s_star = -norm_sstar + 2*norm_sstar.*rand(3,N);

[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(s_star);

s_hat = s_eq3;

C = [];
for i=1:N
    for j=1:N
       if i==j
          continue; 
       end
       si_star = s_star(:,i);
       si_hat = s_hat(:,i);
       sj_star = s_star(:,j);
       sj_hat = s_hat(:,j);
       u0 = si_star - sj_star + si_hat - sj_hat;
       c0 = zeros(3,N);
       c0(:,i) = -u0;
       c0(:,j) = u0;
       C(:,end+1) = c0(:);
       (V'*c0(:) / norm(c0(:)))'
    end 
end
return
C
rank(C)