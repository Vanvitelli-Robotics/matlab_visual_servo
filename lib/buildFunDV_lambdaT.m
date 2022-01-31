function DV = buildFunDV_lambdaT(ek,s_star,Ds_stark,TForwardVel)

if nargin < 4 || isempty(TForwardVel)% || TForwardVel == 0)
    TForwardVel = zeros(6,1);
end

if(nargin < 3 || isempty(Ds_stark))
    Ds_stark = 0;
end


s = ek+s_star;
L = computeL(s);
Lpinv = pinv(L);

f_ekp1 = @(lambdaT)discreteErrorSystemClosedLoop_internal( ...
    lambdaT, ...
    ek, ...
    L, ...
    Lpinv, ...
    Ds_stark, ...
    TForwardVel ...
    );

norm_ek_2 = norm(ek)^2;
DV = @(lambdaT) norm(f_ekp1(lambdaT))^2 - norm_ek_2;

end

