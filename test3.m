T = .1;

[eq1, eq2, eq3] = computeEqPoints(C_features_desired);
eD = min([norm(eq1), norm(eq2), norm(eq3)]);

eG = eD;

sM_v = 0:0.001:3;

y = [];
for sm = sM_v
   
    a = -(eG - (17/2)*T*sm);
    b = (17/4)*T*eG + 2*T^2*sm;
    c = T^2*eG;
    
    r = roots([a b c]);
    
    r = r(r>0);
    
    if( numel(r) == 1)
        y(end+1) = r;
    else
        y(end+1) = nan;
    end
    
end

figure
plot(sM_v,y)
grid on
hold on
plot(sM_v,T*ones(size(sM_v)),'k')
plot(1.26*eG*[1 1], [0 200], 'k')
plot( eG*2/(17*T)*[1 1], [0 200], 'k')