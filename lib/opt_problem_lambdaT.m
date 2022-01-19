function lambdaT = opt_problem_lambdaT(ek,s_star,vTMax,wTMax,Ds_stark,forward_action_enabled, use_majorant)

lambdaT_0 = 0; %<- ...

if(nargin < 7 || isempty(use_majorant))
    use_majorant = false;
end
if(nargin < 6 || isempty(forward_action_enabled))
    forward_action_enabled = true;
end
if(nargin < 5 || isempty(Ds_stark))
    Ds_stark = zeros(size(s_star));
    forward_action_enabled = false;
end

if use_majorant
    DV_maj = buildFunDVmaj_lambdaT(ek,s_star);
    fun = @(lambdaT) DV_maj(lambdaT);
else
    DV = buildFunDV_lambdaT(ek,s_star,Ds_stark,forward_action_enabled);
    fun = @(lambdaT) DV(lambdaT);
end

% compute lambda_max
analitic_lambdaT_max = computeAnaliticLambdaTMax(ek,computeL(ek+s_star),Ds_stark);
forwardActionVelT = computeLpinv(ek+s_star)*Ds_stark;
vel_lambda1 = computeLpinv(ek+s_star)*ek;
max_lambdaT_v = computeLambdaTBound(vel_lambda1(1:3), forwardActionVelT(1:3), vTMax);
max_lambdaT_w = computeLambdaTBound(vel_lambda1(4:6), forwardActionVelT(4:6), wTMax);

if analitic_lambdaT_max < 0
    dummy = 0;
    analitic_lambdaT_max = 0;
end

lambdaT_MAX = min([analitic_lambdaT_max,max_lambdaT_v,max_lambdaT_w]);
% lambdaT_MAX = inf;
if false
   lambdaT_vect = 0:0.001:3;
   DV_vect = zeros(size(lambdaT_vect));
   for i=1:numel(lambdaT_vect)
    DV_vect(i) = fun(lambdaT_vect(i));
   end
   figure(101),hold on,plot(lambdaT_vect,DV_vect);
   grid on
   drawnow;
end

rmse = sqrt(norm(ek)^2/(numel(ek)/3));
if(rmse<0.004)
    lambdaT = analitic_lambdaT_max;
%     lambdaT = min(1,lambdaT_MAX);
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

function max_lambdaT = computeLambdaTBound(unit_gain_v_closed_loop, unit_step_v_forward, max_vT)

if norm(unit_gain_v_closed_loop) < 10*eps
    if norm(unit_step_v_forward) >= max_vT
        warning("Ds_star too big and ek=0");
        max_lambdaT = 0; % convention
        return;
    end
    max_lambdaT = max_vT/norm(unit_gain_v_closed_loop);
    return;
end 

if norm(unit_step_v_forward) < 10*eps
    max_lambdaT = max_vT/norm(unit_gain_v_closed_loop);
    return;
end

a = norm(unit_gain_v_closed_loop)^2;
b = -unit_step_v_forward'*unit_gain_v_closed_loop;
c = norm(unit_step_v_forward)^2 - max_vT^2;
DELTA = b^2 - 4*a*c;
if DELTA <= 0
   warning("Ds_star too big and DELTA<=0");
   max_lambdaT = 0; %convention
else
    sol_1 = (-b+sqrt(DELTA))/(2*a);
    sol_2 = (-b-sqrt(DELTA))/(2*a);
    if sol_1*sol_2 <= 0
        % opposite sign
        max_lambdaT = max(sol_1,sol_2);
        return;
    else
        % same sign
        if sol_1 < 0
            % negative => no solition
            warning("Ds_star too big and solutions<0");
            max_lambdaT = 0; %convention
            return;
        else
            % positive => solution between lambda_min, lambda_max
            % I will choose lambda_max but here we still have a warning
            warning("Ds_star too big and solutions>0");
            max_lambdaT = max(sol_1,sol_2);
            return;
        end
    end
end

end

