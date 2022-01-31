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

if(rmse<(rmse_noise_level+1E-4))
    alph = 1;
else
    alph = normE/normEI;
end

% lambdaT_max = (2 - alph*norm([zeros(3) eye(3)]*Lpinv*Dsstar))/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv*e ) );
lambdaT_max = 1/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv*e ) );
% lambda_max = inf;
% lambda_max = (2/Ts)/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv)*norm(e) );

if not(isempty(l_fcn))
    lambdaT_max = lambdaT_max;%*l_fcn(rmse);
end
return;

MIN = 0.002;
MAX = 0.005;
valMIN = 0.1; % TS
valMAX = 1;
rmse = sqrt(norm(e)^2/(numel(e)/3));

if lambdaT_max < MAX
    lambdaT_max = 1;
end

if rmse > MAX
    val = 1;
elseif rmse < MIN
    val = valMIN;
else
    val = (valMIN-valMAX)/(MIN-MAX) * rmse - (valMIN-valMAX)/(MIN-MAX) * MAX + valMAX;
end
lambdaT_max = lambdaT_max*val;

return
N = 0.001;
rmse = sqrt((norm(e)^2)/(numel(e)/3));
if rmse < N
    lambdaT_max = 0;
    return
end
if rmse < 3*N
    lambdaT_max = (1/(3*N-N))*(lambdaT_max-N);
    return
end

end

