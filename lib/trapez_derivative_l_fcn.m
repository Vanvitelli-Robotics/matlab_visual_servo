function val = trapez_derivative_l_fcn(rmse, rmse_noise_min, slope_max, val_min, b_disabled)
%trapez_derivative_l_fcn trapezoidal scalar trajectory

if nargin < 5 || isempty(b_disabled)
   b_disabled = false;
end

val_max = 1;

if b_disabled
   val = val_max;
   return;
end

ai = 100000.0;
af = ai;
[val,~] = trapezVelTraj(rmse,val_min,val_max,slope_max,ai,af,rmse_noise_min);


