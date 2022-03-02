function [s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(C_features_desired)
% computeEqPoints compute the equilibrium points
%
% C_features_desired: desired features

theta = pi;
I = eye(3);
sstar_m = sum(C_features_desired,2)/size(C_features_desired,2);

[r_eq1] = calcEQrotax(C_features_desired,1);
[r_eq2] = calcEQrotax(C_features_desired,2);
[r_eq3] = calcEQrotax(C_features_desired,3);

R_eq1 = angvec2r(theta,r_eq1);
t_eq1 = (I-R_eq1)*sstar_m;
C_t_Cd = SE3(R_eq1, t_eq1);
s_eq1 = homtrans((C_t_Cd), C_features_desired);

R_eq2 = angvec2r(theta,r_eq2);
t_eq2 = (I-R_eq2)*sstar_m;
C_t_Cd = SE3(R_eq2, t_eq2);
s_eq2 = homtrans((C_t_Cd), C_features_desired);

R_eq3 = angvec2r(theta,r_eq3);
t_eq3 = (I-R_eq3)*sstar_m;
C_t_Cd = SE3(R_eq3, t_eq3);
s_eq3 = homtrans((C_t_Cd), C_features_desired);

end

