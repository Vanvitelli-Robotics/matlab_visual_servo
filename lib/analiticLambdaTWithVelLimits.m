function lambdaT = analiticLambdaTWithVelLimits(analitic_lambdaT_max,ek,s_star,vTMax,wTMax,TForwardVel)

TForwardVel_ = zeros(6,1);
if nargin < 6 || isempty(TForwardVel) || norm(TForwardVel) == 0
    TForwardVel_ = zeros(6,1);
else
    TForwardVel_ = TForwardVel(:);
end

% compute lambda_max
vel_lambda1 = computeLpinv(ek+s_star)*ek;
max_lambdaT_v = computeLambdaTBound(vel_lambda1(1:3), TForwardVel_(1:3), vTMax);
max_lambdaT_w = computeLambdaTBound(vel_lambda1(4:6), TForwardVel_(4:6), wTMax);

lambdaT = min([analitic_lambdaT_max,max_lambdaT_v,max_lambdaT_w]);

if lambdaT < 0
    disp("lambdaT < 0");
    lambdaT = 0;
end

end

