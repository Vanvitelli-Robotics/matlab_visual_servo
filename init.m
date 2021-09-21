%% add path
addpath('lib\')

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
lambda_const = 1;
vMax = .5;
wMax = deg2rad(10);

% W_T_C_0 = initial Camera pose w.r.t. world frame
W_T_C_0 = W_T_C_desired*SE3(roty(20)*rotz(35), [-.2, -.2, -1]');
% W_T_C_0 = W_T_C_desired*SE3(roty(20)*rotz(10), [.2, .2, -1]');
% W_T_C_0 = W_T_C_desired*SE3(roty(20)*rotz(10), [10, 10, -10]');
% W_T_C_0 = W_T_C_desired*SE3(roty(180)*rotz(180), [10, 10, -10]');
% W_T_C_0 = W_T_C_desired*SE3(roty(90)*rotz(90), [0.1, 0.1, -0.25]');
% W_T_C_0 = W_T_C_desired*SE3(roty(0)*rotz(0), [-.2, -.2, -1]');
% W_T_C_0 = W_T_C_desired*SE3(roty(70)*rotz(70), [0, 0, 0]');
% W_T_C_0 = W_T_C_desired*SE3(roty(20)*rotz(10), [10, 10, -10]');
% W_T_C_0 = W_T_C_desired*SE3(roty(180)*rotz(180), [10, 10, -10]');
% W_T_C_0 = W_T_C_desired*SE3(roty(179)*rotz(179), [.2, .2, -1]');

W_p_C_0 = W_T_C_0.transl';
W_q_C_0 = rotm2quat(W_T_C_0.R);

% C_features_0 = features w.r.t. Camera initial frame
C_features_0 = homtrans(inv(W_T_C_0), W_features);

% Compute the desired camera pose w.r.t. the initial camera pose with the
% algorithm on the features
[C0_T_Cdesired__alg] = computeTfeatures(C_features_0,C_features_desired);
C0_T_Cdesired__alg = inv(C0_T_Cdesired__alg); % inversion needed
% W_T_Cdesired_alg = camera desired pose w.r.t. world frame (after
% algorithm)
W_T_Cdesired_alg = W_T_C_0 * C0_T_Cdesired__alg;

% C0_T_Cdesired = camera desired pose w.r.t. initial camera frame (actual)
C0_T_Cdesired = inv(W_T_C_0) * W_T_C_desired;
% Cdesired_T_C0 = initial camera pose w.r.t. desired camera frame (actual)
Cdesired_T_C0 = inv(C0_T_Cdesired);
% W_T_Cdesired = camera desired pose w.r.t. world frame (actual)
W_T_Cdesired = W_T_C_0 * C0_T_Cdesired;

%% System

s0 = C_features_0(:);
output_DT = Ts;
control_DT = Ts;

return;


%W_T_C_0 = W_T_C_desired*SE3(roty(20)*rotz(10), [10, 10, -10]');
%W_T_C_0 = W_T_C_desired*SE3(roty(180)*rotz(180), [10, 10, -10]');
%W_p_C_0 = W_T_C_0.transl';
%W_q_C_0 = rotm2quat(W_T_C_0.R);

%C_features_0 = homtrans(inv(W_T_C_0), W_features);
%error_0 = C_features_0(:) - C_features_desired(:);
error_0 = zeros(size( C_features_0(:)))

T_perturb = SE3(rotx(-1*0)*roty(-1*0)*rotz(-1*0),[.1 .1 .1]);
C_features_0_perturb = homtrans(T_perturb, C_features_0);
s_0 = C_features_0_perturb(:);

Ts_output = 1/30;

%lambda = 0.2/0.1;
Ts_zoh = 0.1;
find_lambda;
%lambda = 0.6/Ts_zoh;
lambda = 6.5;


