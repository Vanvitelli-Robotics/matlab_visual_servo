
addpath('./lib')

N = 4;
lambdaT = 1;
Ds_stark = 0.001*randn(3*N,1);
s_star = randn(3*N,1);

DV = -1;
DV2 = -1;

rr = 0;
nDsstar2 = Ds_stark'*Ds_stark;
nDsstar = norm(Ds_stark);

while DV < eps && DV2 < eps
    
    ek = 100 + rr.*randn(3*N,1);
    
    s = ek+s_star;
    L = computeL(s);
    Lpinv = pinv(L);
    ekp1 = discreteErrorSystemClosedLoop_internal(lambdaT, ek, L, Lpinv, Ds_stark, false );
    
    DV = ekp1'*ekp1 - ek'*ek;
    
    eI = L*Lpinv*ek;
    eN = ek - eI;
    
%     nEI2 = 1;
%     nEN2 = rr + 1000*rr*randn;
%     nE2 = nEI2 + nEN2;
    
    nEI = norm(eI);
    nEN = norm(eN);
    nE = norm(ek);
%     nEI = sqrt(nEI2);
%     nEN = sqrt(nEN2);
%     nE = sqrt(nE2);
    
    unitGainVel = Lpinv*ek;
    unitGainRotVel = unitGainVel(4:6);
    nW1 = norm(unitGainRotVel);
    
    DV2 = nDsstar2 + 2*((1-lambdaT)*nDsstar*nEI + nDsstar*nEN) - lambdaT*nEI*(2*nEI - lambdaT*(nEI+nW1*(nE + nDsstar)));
    
    rr = rr + .1;
    %rr
    alpha = nE/nEI;
    if alpha > 100
       alpha 
    end
    
end