
T = .1;

sM_v = 0:0.1:2;
eG_v = 0:0.1:1;

[SM, EG] = meshgrid(sM_v,eG_v);

% syms beta real

Y = zeros(size(SM));
for i = 1:numel(SM)
    
    sm = SM(i);
    eG = EG(i);
    
%     lT = eG/(eG + 2*beta*sm);
%     alpha2 = 1 + beta*sm/sqrt(eG^2 - beta^2*sm^2);
    
% beta = 0:0.01:10;
    
    Sqr = @(beta) sqrt( eG^2 - beta.^2*sm^2 );
    par = @(beta) eG+2*beta*sm;
    
    
    y = @(beta) -eG*beta.^2.*Sqr(beta) + (9/4)*beta.*T.*par(beta).*Sqr(beta) + T^2.*par(beta).*Sqr(beta);
    
    initial_point = 10*T;
    if not(isreal(y(initial_point)))
        Y(i) = nan;
        continue;
    end
    X = fzero(y,initial_point);
    
    if (isreal(X) && X>0)
        Y(i) = X;
    else
        Y(i) = nan;
    end
    
    
    
end

figure
surf(SM,EG,Y,'LineStyle','none')
hold on
xlabel('SM'), ylabel('EG'), zlabel('y')
grid on