function lambdaT_max = computeAnaliticLambdaTMax(e,L,Dsstar,TForwardVel, rmse_noise_level, l_fcn)
% computeAnaliticLambdaTMax compute the maximum analitic lambda taking into
% account the constraint of the optimization problem P1
%
% e: visual servoing error
% L: interaction matrix (L(s))
% Dsstar,TForwardVel should be zero, don't use it
% rmse_noise_level: noise level of the measured featurs, it is used to
% avoid 0/0 in the conputation of alpha. It can be set to zero in
% simulation.
% l_fcn: landing function handler

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
