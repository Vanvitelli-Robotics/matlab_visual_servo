function DV_maj = buildFunDVmaj_lambdaT(ek,s_star, l_fcn_value)
% buildFunDVmaj_lambdaT build the function handler pi(lambdaT) (see paper)
% 
% ek: visual servoing error
% s_star: reference features
% l_fcn_value: value of the landing function


if nargin < 3 || isempty(l_fcn_value)
    l_fcn_value = 1;
end

s = ek+s_star;
L = computeL(s);
Lpinv = pinv(L);
norm_e = norm(ek);
norm_eI = norm( L*Lpinv*ek );

N_features = numel(ek)/3;
rmse = norm_e/N_features;
if(rmse<10*eps)
    alpha = 1; 
else
    alpha = norm_e/norm_eI;
end
unit_gain_vel = [zeros(3) eye(3)]*Lpinv*ek;
norm_unit_gain_vel = norm(unit_gain_vel);
DV_maj = @(lambdaT) -lambdaT*(2*l_fcn_value - lambdaT*alpha*norm_unit_gain_vel - lambdaT) * (norm_eI^2);

end

