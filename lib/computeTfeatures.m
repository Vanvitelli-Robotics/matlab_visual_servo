function [initial_T_final] = computeTfeatures(s_initial,s_final)
%COMPUTETFEATURES Summary of this function goes here
%   Detailed explanation goes here

options = optimoptions(@fminunc,'Display','none',...
    'MaxIterations',1000,...
    'OptimalityTolerance',1e-12, ...
    'StepTolerance',1e-13); 
x0 = [1 0 0 0 0 0 0];
fun = @(x) f_cst(x(1:4), x(5:7), s_initial,s_final);
[x,fval,exitflag,output] = fminunc(fun,x0,options);
x(1:4) = unit(x(1:4));

initial_R_final = quat2rotm(x(1:4));
initial_P_final = x(5:7);

initial_T_final = SE3(initial_R_final,initial_P_final);

end

function cst = f_cst(initial_Q_final, initial_P_final, s_initial,s_final)

n = size(s_initial,2);

initial_Q_final = unit(initial_Q_final);
initial_R_final = quat2rotm(initial_Q_final);

cst = 0;
for i=1:n
    cst = cst + norm(residual(initial_R_final, initial_P_final, s_initial(:,i), s_final(:,i)))^2;
end

cst = cst/2;

end

function r = residual(initial_R_final, initial_P_final, si_initial, si_final)


% hat_si_final = initial_R_final*si_initial + initial_P_final(:);
% 
% r = hat_si_final - si_final;

hat_si_initial = initial_R_final*si_final + initial_P_final(:);

r = hat_si_initial - si_initial;

end
