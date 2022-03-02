%% clear
clear all, close all

%% path
addpath('..\..\lib\')
vs_set_lib_path

%% params

Ts = 0.1;
lambda = 5;

load_O_features;

C0_T_Cd = SE3(rotx(30)*roty(15)*rotz(5), [0.2, 0.1, 0.3]');

%% init

s_star = C_features_desired(:);

C0_features = homtrans(C0_T_Cd,C_features_desired);

s0 = C0_features(:);