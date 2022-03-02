function [vf, funval, exitflag] = computeForwardAction(s_star_k, s_star_kp1, T, vf0, s, closed_loop_rot_vel)
% computeForwardAction compute the forward action

if nargin < 6
    closed_loop_rot_vel = zeros(3,1);
end
if nargin < 5
    s = s_star_k;
end

N = numel(s_star_k)/3;
Ls = computeL(s);
Ds_star = s_star_kp1 - s_star_k;


fun = @(v)( matrixBar(integralOfConstAxR(-(v(4:6)+closed_loop_rot_vel),T),N)*Ls*v - Ds_star );
% options = optimoptions('fsolve','Display','none','Algorithm','levenberg-marquardt');
% [vf,funval,exitflag,output] = fsolve(fun,vf0,options);

fun_opt = @(v) (norm(fun(v))^2);
max_iter = 10000;
options = optimset('Display','none','TolFun',1e-15,'TolX',1e-15,'MaxIter',max_iter, 'MaxFunEvals', 100*max_iter);
[vf,funval,exitflag,output] = fminsearch(fun_opt,vf0,options);

end

