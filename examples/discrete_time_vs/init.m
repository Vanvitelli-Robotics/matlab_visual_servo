%% add path
addpath('..\..\lib\')
addpath('..\..\lib\simulink')

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

% W_T_C_0 = initial Camera pose w.r.t. world frame
% W_T_C_0 = W_T_C_desired*SE3(roty(180)*rotz(0), [.2, .2, -.5]');
% W_T_C_0 = W_T_C_desired*SE3(roty(180)*rotz(0), [.2, .2, -.5]');
% W_T_C_0 = W_T_C_desired*SE3(roty(1)*rotz(1), [0.01, 0, 0]');
% W_T_C_0 = W_T_C_desired*SE3(roty(20)*rotz(10), ([1, 1, -1]/4.442636782659956)');
% W_T_C_0 = W_T_C_desired*SE3(rotz(180)*roty(10), [10, 10, -10]');
% W_T_C_0 = W_T_C_desired*SE3(roty(90)*rotz(90), [0.1, 0.1, -0.25]');
% W_T_C_0 = W_T_C_desired*SE3(roty(0)*rotz(0), [-.2, -.2, -1]');
% W_T_C_0 = W_T_C_desired*SE3(roty(70)*rotz(70), [0, 0, 0]');
% W_T_C_0 = W_T_C_desired*SE3(roty(20)*rotz(10), [10, 10, -10]');
% W_T_C_0 = W_T_C_desired*SE3(roty(180)*rotz(180), [10, 10, -10]');
% W_T_C_0 = W_T_C_desired*SE3(roty(180)*rotz(30), [.1, .1, -0.2]');

% % rotax = sum(C_features_desired,2)/size(C_features_desired,2);
% % rotax = rand(3,1);
% % rotax = [0;1;0];
[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(C_features_desired);
[rotax] = (r_eq3+r_eq2)/2;
rotax = unit(rotax);
% % rotax = unit(rand(3,1));
% % rotax = [-0.4538   -0.8911   -0.0001]';
rotang = deg2rad(120);
R_0 = angvec2r(rotang,rotax);
t_0 = (eye(3)-R_0)*sum(C_features_desired,2)/size(C_features_desired,2);
t_0 = t_0*0 + [1; 0; 0]; % 1e-4 = converge a shat
% % t_0 = t_0 + [0; ll; 0];
Cd_T_C0_ins = SE3(R_0, t_0);
W_T_C_0 = W_T_C_desired*SE3(R_0, t_0);
% % W_T_C_0 = W_T_C_desired*SE3(roty(180)*rotx(0), [0, 0, 0]');


W_p_C_0 = W_T_C_0.transl';
W_q_C_0 = rotm2quat(W_T_C_0.R);

% C_features_0 = features w.r.t. Camera initial frame
 W_T_C_0_pert = W_T_C_0;
%  W_T_C_0_pert = W_T_C_0*(Cd_T_C0_ins);
% W_T_C_0_pert = SE3([ rotx(180) [0 0 0]'; 0 0 0 1 ]);
% W_T_C_0_pert = W_T_C_0 * SE3([ rotx(180)*roty(180)*rotz(180) [0 0 0.0]'; 0 0 0 1 ]);
% W_T_C_0_pert = W_T_C_desired*SE3(roty(180)*rotz(0), [.2, .2, -.5]');
C_features_0_pert = homtrans(inv(W_T_C_0_pert), W_features);
C_features_0 = homtrans(inv(W_T_C_0), W_features);

% % Compute the desired camera pose w.r.t. the initial camera pose with the
% % algorithm on the features
% [C0_T_Cdesired__alg] = computeTfeatures(C_features_0,C_features_desired);
% C0_T_Cdesired__alg = inv(C0_T_Cdesired__alg); % inversion needed
% % W_T_Cdesired_alg = camera desired pose w.r.t. world frame (after
% % algorithm)
% W_T_Cdesired_alg = W_T_C_0 * C0_T_Cdesired__alg;
% 
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

%% sim e_tilde
% lambda_const = 1/Ts;
%  s_star = C_features_desired(:);
%  lambda = lambda_const*.5;
%  r_eq = calcEQrotax(C_features_desired,3);
%  R_eq = angvec2r(deg2rad(180),r_eq);
%  t_eq = (eye(3)-R_eq)*sum(C_features_desired,2)/size(C_features_desired,2);
%  s_eq = homtrans([R_eq, t_eq; 0 0 0 1], C_features_desired);
%  s_eq = s_eq(:);
%  e_eq = s_eq - s_star;
% return
%  s_star, lambda, e_eq

