function skp1 = discreteFeatureSystem(Ts, sk, vk)
%discreteErrorSystem computes the next sampled time feature vector sp1 given the
%current one sk and the system inputs.

N_features = numel(sk)/3;

L = computeL(sk);
rotVel = vk(4:6);
INT = matrixBar(integralOfConstAxR(-rotVel,Ts),N_features);
skp1 = sk + INT*L*vk;



