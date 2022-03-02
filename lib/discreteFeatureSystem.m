function skp1 = discreteFeatureSystem(Ts, sk, vk)

N_features = numel(sk)/3;

L = computeL(sk);
rotVel = vk(4:6);
INT = matrixBar(integralOfConstAxR(-rotVel,Ts),N_features);
skp1 = sk + INT*L*vk;



