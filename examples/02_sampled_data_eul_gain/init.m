%% clear
clear all, close all

%% path
addpath('..\..\lib\')
vs_set_lib_path

%% params

Ts = 0.1;
lambda = 1.9/Ts;

load_O_features;

C0_T_Cd = SE3(rotx(60)*roty(60)*rotz(60), [0.2, 0.1, 0.3]');

%% init

s_star = C_features_desired(:);

C0_features = homtrans(C0_T_Cd,C_features_desired);

s0 = C0_features(:);