
t_m = 0.82;
t = out.b_s.Time;
indx = find(t>t_m,1);

T = Ts;
Dsstar_max =  0.1353;
dotsstar_max = 0.9048;

s = out.b_s.Data(indx,:);
sstar = out.b_sstar.Data(indx,:);
lambda = out.b_lambda.Data(indx,:);
DS_star = out.b_Ds_star.Data(indx,:);


save('test_beta_ws', 'T', 'Dsstar_max', 'dotsstar_max', 's', 'sstar', 'lambda', 'DS_star');
