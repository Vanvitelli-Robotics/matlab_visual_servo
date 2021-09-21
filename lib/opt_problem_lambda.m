function lambda = opt_problem_lambda(ek,s_star,Ts,vMax,wMax,Ds_stark,forward_action_enabled, use_majorant)

lambda_0 = 0; %<- ...

if(nargin < 8 || isempty(use_majorant))
    use_majorant = false;
end
if(nargin < 7 || isempty(forward_action_enabled))
    forward_action_enabled = true;
end
if(nargin < 6 || isempty(Ds_stark))
    Ds_stark = 0;
    forward_action_enabled = false;
end

if use_majorant
    DV_maj = buildFunDVmaj_lambda(ek,s_star,  Ts);
    fun = @(lambda) DV_maj(lambda);
else
    DV = buildFunDV_lambda(ek,s_star,Ts,Ds_stark,forward_action_enabled);
    fun = @(lambda) DV(lambda)*1000;
end

% compute lambda_max
vel_lambda1 = computeLpinv(ek+s_star)*ek;
if(norm(vel_lambda1) > 0)
    lambda_wMAX = wMax/norm([zeros(3) eye(3)]*vel_lambda1);
    lambda_vMAX = vMax/norm([eye(3) zeros(3)]*vel_lambda1);
    lambda_MAX = min(lambda_vMAX,lambda_wMAX);
else 
    lambda_MAX = inf;
end

% optimize
options = optimoptions('fmincon',...
    'ConstraintTolerance',1e-6,...
    'OptimalityTolerance',1e-13,...
    'StepTolerance', 1e-13 ...
    ...,'ScaleProblem', true ...
    );
lambda = fmincon(fun,lambda_0,[],[],[],[],0,lambda_MAX, [], options);
% lambda = fminunc(fun,lambda_0);

end

