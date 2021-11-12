
b_star = sum(C_features_desired,2)/size(C_features_desired,2);

% W_T_C__ = W_T_C_0;
W_T_C__ = SE3(quat2rotm(out.quaternion.Data(end,:)),out.position.Data(end,:));

DT = inv(W_T_C__)*W_T_C_desired;
DR = SO3(DT.R);

[theta, r] = DR.toangvec;
r = r(:);

DR12 = angvec2r(theta/2,r);

(eye(3)-DR.R)*b_star - DT.t


%% secondo membro
secondom = skew(b_star)*skew(DR12'*b_star)*r

%% primo membro

primom = zeros(3,1);
for i=1:size(C_features_desired,2)
    
    s_star_i = C_features_desired(:,i);
    ttt = skew(s_star_i)*skew(DR12'*s_star_i)*r
    primom = primom + ttt;
end
primom = primom/size(C_features_desired,2)

%% test 2
% secondo
M2 = zeros(3,3);
for i=1:size(C_features_desired,2)
    s_star_i = C_features_desired(:,i);
    M2 = M2 + (r'*s_star_i)*skew(s_star_i);
end
M2 = (M2)/size(C_features_desired,2);
M1 = (r'*b_star)*skew(b_star);
MM = M1-M2;
