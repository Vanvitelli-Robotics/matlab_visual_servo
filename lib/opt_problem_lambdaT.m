function lambdaT = opt_problem_lambdaT(ek,s_star,vTMax,wTMax,Ds_stark,TForwardVel, rmse_noise_level,analitic_lambdaT_max)

lambdaT_0 = 0; %<- ...

if(nargin < 7 || isempty(rmse_noise_level))
    rmse_noise_level = 0;
end

if nargin < 6 || isempty(TForwardVel) || norm(TForwardVel) == 0
    TForwardVel_ = zeros(6,1);
else
    TForwardVel_ = TForwardVel;
end

if(nargin < 5 || isempty(Ds_stark))
    Ds_stark = 0;
end

DV = buildFunDV_lambdaT(ek,s_star,Ds_stark,TForwardVel_);
fun = @(lambdaT) DV(lambdaT);

% compute lambda_max
vel_lambda1 = computeLpinv(ek+s_star)*ek;
max_lambdaT_v = computeLambdaTBound(vel_lambda1(1:3), TForwardVel_(1:3), vTMax);
max_lambdaT_w = computeLambdaTBound(vel_lambda1(4:6), TForwardVel_(4:6), wTMax);

lambdaT_MAX = min([analitic_lambdaT_max,max_lambdaT_v,max_lambdaT_w]);
% lambdaT_MAX = inf;

if lambdaT_MAX < 0
    warning("lambdaT_MAX < 0");
    lambdaT_MAX = 0;
end

rmse = norm(ek)/sqrt((numel(ek)/3));
if(rmse<(rmse_noise_level+1E-4))
    lambdaT = lambdaT_MAX;
    return;
end

% optimize
options = optimoptions('fmincon',...
    'ConstraintTolerance',1e-6,...
    'OptimalityTolerance',1e-13,...
    'StepTolerance', 1e-13 ...
    ...,'ScaleProblem', true ...
    );
lambdaT = fmincon(fun,lambdaT_0,[],[],[],[],0,lambdaT_MAX, [], options);
% lambda = fminunc(fun,lambda_0);

end