init
[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(C_features_desired);

figure(1)
hold on
for ang=0:0.00001:0.001
DR = rotx(ang);
R = R_eq3*DR;
p = t_eq3;
T = SE3(R,p);
s = homtrans(T,reshape(s_star_end,3,numel(s_star_end)/3));

L = computeL(s);
e = s(:)-s_star_end(:);
eI = L*pinv(L)*e;
eN = e-eI;

plot(norm(eN),norm(eI),'r.');

end

plot([1 1]*norm(s_eq3(:)-s_star_end(:)), [0 norm(eI)],'k-')