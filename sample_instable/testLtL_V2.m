addpath('../')

clear all;

N = 3;
s_star = rand(3,N);
[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(s_star);

shat = s_eq3;

Lsstar = computeL(s_star);
Lshat = computeL(shat);

a = -1e-9; b = 1e-9;
eps_pr = a + (b-a).*rand(6,1);

invL = inv(Lshat'*Lshat);
eps_pr'*Lsstar'*Lshat*invL*Lsstar'*(s_star(:)-shat(:)) - ...
eps_pr'*Lsstar'*Lshat*invL*(Lsstar'*Lsstar)*eps_pr
