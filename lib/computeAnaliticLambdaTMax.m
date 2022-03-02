function lambdaT_max = computeAnaliticLambdaTMax(e,L,Dsstar,TForwardVel, rmse_noise_level, l_fcn)

if(nargin < 6 || isempty(l_fcn))
    l_fcn = [];
end

if(nargin < 5 || isempty(rmse_noise_level))
    rmse_noise_level = 0;
end

if nargin < 4 || isempty(TForwardVel)% || all(TForwardVel == 0))
    TForwardVel = zeros(6,1);
end

if(nargin < 3 || isempty(Dsstar))
    Dsstar = 0;
end


Lpinv = pinv(L);
eI = L*Lpinv*e;

normEI = norm(eI);
normE = norm(e);

rmse = normE/sqrt(numel(e)/3);

if(rmse<(rmse_noise_level+(10*eps)))
    alph = 1;
else
    alph = normE/normEI;
end

lambdaT_max = 1/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv*e ) );

if isempty(l_fcn)
    lambdaT_max = lambdaT_max;%*l_fcn(rmse);
else
    lambdaT_max = lambdaT_max*l_fcn(rmse);
end
