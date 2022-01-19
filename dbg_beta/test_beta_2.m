clear all
close all

load test_beta_ws.mat

% vars alpha, w;

alpha2_v = 1:0.1:3;
alph_w1_v = 0:0.1:3;

[ALPHA2,ALPH_W1] = meshgrid(alpha2_v,alph_w1_v);
BETA = zeros(size(ALPHA2));

for i=1:numel(ALPHA2)
    
alpha2 = ALPHA2(i);
alph_w1 = ALPH_W1(i);

lTopt = 1/(1+alpha2*alph_w1);
% lTopt = lambda*T;

beta = ...
( ...
alpha2^2*T*(1+lTopt) + ...
    alpha2*T* ...
    sqrt( ...
        alpha2^2*(1+2*lTopt+lTopt^2) + ...
        (2*lTopt-alpha2*lTopt^2*alph_w1-lTopt^2) ...
        ) ...
)/ ...
(2*lTopt-alpha2*lTopt^2*alph_w1-lTopt^2);

BETA(i) = beta;

end

figure
surf(ALPHA2,ALPH_W1,BETA);
xlabel('alpha');
ylabel('w1');
zlabel('beta');
