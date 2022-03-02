%% clear
clear all, close all

%% path
addpath('..\..\lib\')
vs_set_lib_path

%% params

Ts = 0.1;
vMax = inf;%0.5;
wMax = inf;%0.6;

load_O_features;

[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(C_features_desired);
[rotax] = (r_eq3+r_eq2)/2;
rotax = unit(rotax);
rotang = deg2rad(180);
R_0 = angvec2r(rotang,rotax);
% t_0 = (eye(3)-R_0)*sum(C_features_desired,2)/size(C_features_desired,2);
% t_0 = t_0*0 + [1; 0; 0]; % 1e-4 = converge a shat
t_0 = [.3; 0; 0];
% % t_0 = t_0 + [0; ll; 0];
Cd_T_C0_ins = SE3(R_0, t_0);
% W_T_C_0 = W_T_C_desired*SE3(R_0, t_0);
C0_T_Cd = inv(Cd_T_C0_ins);

% C0_T_Cd = SE3(rotx(180)*roty(180)*rotz(180), [0.2, 0.1, 0.3]');

% C0_T_Cd = SE3(rotx(0.1)*roty(0.1)*rotz(0.1), [0.001, 0.001, 0.001]');

%% init

s_star = C_features_desired(:);

C0_features = homtrans(C0_T_Cd,C_features_desired);

s0 = C0_features(:);