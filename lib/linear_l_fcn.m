function val = linear_l_fcn(rmse, rmse_noise_min, rmse_noise_max, val_min, b_disabled)
% a linear version of the landing function (not really used)

if nargin < 5 || isempty(b_disabled)
   b_disabled = false;
end

val_max = 1;

if b_disabled
   val = val_max;
   return;
end

if rmse > rmse_noise_max
    val = 1;
elseif rmse < rmse_noise_min
    val = val_min;
else
    val = (val_min-val_max)/(rmse_noise_min-rmse_noise_max) * rmse - (val_min-val_max)/(rmse_noise_min-rmse_noise_max) * rmse_noise_max + val_max;
end

end

