function ekp1 = discreteErrorSystemClosedLoop_internal(lambdaT, ek, L, Lpinv, Ds_stark, TForwardVel)

if nargin < 6 || isempty(TForwardVel)% || TForwardVel == 0)
    TForwardVel = zeros(6,1);
end

if(nargin < 5 || isempty(Ds_stark))
    Ds_stark = 0;
end

N_features = numel(ek)/3;

if lambdaT < 10*eps
    normalizedForwardVel = TForwardVel;
    normalizedForwardRotVel = normalizedForwardVel(4:6);
    INT = matrixBar(integralOfConstAxR(-normalizedForwardRotVel,1),N_features);
    ekp1 = ek + INT*L*normalizedForwardVel - Ds_stark;
else
    normalizedForwardVel = TForwardVel/lambdaT;
    normalizedForwardRotVel = normalizedForwardVel(4:6);
    unitGainVel = Lpinv*ek;
    unitGainRotVel = unitGainVel(4:6);
    INT = matrixBar(integralOfConstAxR(unitGainRotVel - normalizedForwardRotVel,lambdaT),N_features);
    ekp1 = ek - INT*L*(unitGainVel - normalizedForwardVel) - Ds_stark;
end

