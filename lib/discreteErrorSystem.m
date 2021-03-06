function ekp1 = discreteErrorSystem(Ts, ek, s_star_k, vk, Ds_stark)
%discreteErrorSystem computes the next sampled time error ekp1 given the
%current error ek and the system inputs.


if(nargin < 5 || isempty(Ds_stark))
    Ds_stark = 0;
end

N_features = numel(ek)/3;

L = computeL(ek + s_star_k);
rotVel = vk(4:6);
INT = matrixBar(integralOfConstAxR(-rotVel,Ts),N_features);
ekp1 = ek + INT*L*vk - Ds_stark;



