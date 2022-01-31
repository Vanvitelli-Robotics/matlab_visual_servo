function val = trapez_derivative_l_fcn(rmse, rmse_noise_min, slope_max, val_min)

ai = 100000.0;
af = ai;
[val,~] = trapezVelTraj(rmse,val_min,1,slope_max,ai,af,rmse_noise_min);


