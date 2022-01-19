init
[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(C_features_desired);

L = computeL(s_eq1(:));
l1 = eig(L'*L);

L = computeL(s_eq2(:));
l2 = eig(L'*L);

L = computeL(s_eq3(:));
l3 = eig(L'*L);