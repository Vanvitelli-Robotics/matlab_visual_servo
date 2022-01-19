

K = 0:0.01:1;
T = 0.1;

alph_M = (1+K./sqrt(1-K.^2));
lT_m = 1-K./3;
eps_M = alph_M.*T.*(T+4)./lT_m;

% eps = max(1,eps_M);
eps = eps_M;

coeff = K./eps;

figure
plot(K,coeff)