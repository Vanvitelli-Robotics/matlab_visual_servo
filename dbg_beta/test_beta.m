clear all
close all

load test_beta_ws.mat

% vars alpha, w;

alpha_v = 1:0.1:3;
w1_v = 0:0.1:3;

[ALPHA,W1] = meshgrid(alpha_v,w1_v);
BETA = zeros(size(ALPHA));

for i=1:numel(ALPHA)
    
alpha = ALPHA(i);
w1 = W1(i);

lTopt = 1/(1+alpha*w1);
% lTopt = lambda*T;

beta = ...
( ...
alpha^2*T*(1+lTopt) + ...
    alpha*T* ...
    sqrt( ...
        alpha^2*(1+2*lTopt+lTopt^2) + ...
        (2*lTopt-alpha*lTopt^2*w1-lTopt^2) ...
        ) ...
)/ ...
(2*lTopt-alpha*lTopt^2*w1-lTopt^2);

BETA(i) = beta;

end

figure
surf(ALPHA,W1,BETA);
xlabel('alpha');
ylabel('w1');
zlabel('beta');
