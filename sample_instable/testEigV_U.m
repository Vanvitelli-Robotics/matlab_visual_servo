clear all
close all

addpath('../lib')

ind_sstar_max = 1;
N_MAX = 4;
norm_sstar = 1; % unitario


    N = randi([N_MAX N_MAX]);
    s_star = -norm_sstar + 2*norm_sstar.*rand(3,N);
    % s_star = rand(3,N)*norm_sstar;



[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(s_star);

Lsstar = computeL(s_star);

% 1
Lseq = computeL(s_eq1);
U = -Lseq*inv(Lseq'*Lseq)*(Lsstar');

% all(real(eig(U))>0)
eig(U)

% 2
Lseq = computeL(s_eq2);
U = -Lseq*inv(Lseq'*Lseq)*(Lsstar');

% all(real(eig(U))>0)
eig(U)

% 3
Lseq = computeL(s_eq3);
U = -Lseq*inv(Lseq'*Lseq)*(Lsstar');

% all(real(eig(U))>0)
eig(U)

[V,D] = eig(U);

proj = Lseq*pinv(Lseq);
for i = 1:size(V,2)
    if(norm(proj*V(:,i)) - norm(V(:,i)) < 10*eps)
        D(i,i)
    end
end
