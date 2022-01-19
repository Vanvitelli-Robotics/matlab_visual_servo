alph = 2;

T = 0:0.01:1;
lT = 0:0.01:2;

[TT, LTT] = meshgrid(T,lT);

YY = alph.^2.*TT.^2+2.*alph.*(1+LTT)./(LTT);

figure
surf(TT,LTT,YY,'LineStyle','none');
xlabel('T');
ylabel('lT')
zlabel('Y')