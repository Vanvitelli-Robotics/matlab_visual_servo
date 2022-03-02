%% add path
addpath('..\..\lib\')
addpath('..\..\lib\simulink')

lambda = 10;

% O = Object
% C = camera
% W = space/world

% O_features = features w.r.t. Object frame
% O_T_C_desired = camera desired pose w.r.t. Object frame
load_O_features;

% C_features_desired = desired features w.r.t. Camera frame (s_star)
C_features_desired = inv(O_T_C_desired) * O_features;

% Object pose w.r.t. world frame
W_T_O = SE3;

% Desired Camera pose w.r.t. world frame
W_T_C_desired = W_T_O*O_T_C_desired;

% W_features = features w.r.t. World frame
W_features = W_T_O*O_features;

%% for simulation

Ts = 0.1;
lambdaT_const = 1;
vMax = .5;
wMax = deg2rad(20);

[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(C_features_desired);
[rotax] = (r_eq3+r_eq2)/2;
rotax = unit(rotax);
rotang = 0* deg2rad(120);
R_0 = angvec2r(rotang,rotax);
t_0 =  [1; 0; 0]; 
W_T_C_0 = W_T_C_desired*SE3(R_0, t_0);


W_p_C_0 = W_T_C_0.transl';
W_q_C_0 = rotm2quat(W_T_C_0.R);

% C_features_0 = features w.r.t. Camera initial frame
C_features_0 = homtrans(inv(W_T_C_0), W_features);

% C0_T_Cdesired = camera desired pose w.r.t. initial camera frame (actual)
C0_T_Cdesired = inv(W_T_C_0) * W_T_C_desired;
% Cdesired_T_C0 = initial camera pose w.r.t. desired camera frame (actual)
Cdesired_T_C0 = inv(C0_T_Cdesired);
% W_T_Cdesired = camera desired pose w.r.t. world frame (actual)
W_T_Cdesired = W_T_C_0 * C0_T_Cdesired;

%% System

s_star_end = C_features_desired(:);
s0 = C_features_0(:);
e0 = s0 - C_features_desired(:); % should be 0 if eo=0;

C_features_0_ = homtrans(inv(W_T_C_0)*SE3(rotx(5),[0 0.2 0.01]), W_features);
s0_ = C_features_0_(:);
e0_ = s0_ - C_features_desired(:);



