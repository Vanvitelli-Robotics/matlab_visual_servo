function DV_maj = buildFunDVmaj_lambdaT(ek,s_star)

s = ek+s_star;
L = computeL(s);
Lpinv = pinv(L);
norm_e = norm(ek);
norm_eI = norm( L*Lpinv*ek );
% norm_eN = norm(( eye(numel(ek)) -  L*Lpinv)*ek);

% sinc_ = @(x) sinc(x/pi);
% f = @(wT2) abs( exp(1i*wT2)*sinc_(wT2) -1 );

% DV_maj =  @(lambda) -lambda*Ts*norm_eI*(2*norm_eI - f(wT(lambda))*norm_eI - f(wT(lambda))*norm_eN - lambda*Ts*norm_eI);
% DV_maj = @(lambda) -2*lambda*Ts*(1- (((norm_e^2)/(norm_eI^2))/Ts) * ((lambda*(Ts/2)*norm_e)/min(svd(L'*L))) - .5*lambda*Ts ) * (norm_eI^2);
% DV_maj = @(lambda) -2*lambda*Ts*(1- (((norm_e^2)/(norm_eI^2))/Ts) * wT(lambda) - .5*lambda*Ts ) * (norm_eI^2);
% DV_maj = @(lambda) -2*lambda*Ts*(1- (((norm_e^2)/(norm_eI^2))/Ts) * ((lambda*(Ts/2)*norm(Lpinv*ek))) - .5*lambda*Ts ) * (norm_eI^2);
% DV_maj = @(lambda) -2*lambda*Ts*(1- (((norm_e^2)/(norm_eI^2))/Ts) * ((lambda*(Ts/2)*norm(Lpinv*ek))) - .5*lambda*Ts ) * (norm_eI^2);

alpha = norm_e/norm_eI;
unit_gain_vel = [zeros(3) eye(3)]*Lpinv*ek;
norm_unit_gain_vel = norm(unit_gain_vel);
DV_maj = @(lambdaT) -lambdaT*(2- lambdaT*alpha*norm_unit_gain_vel - lambdaT) * (norm_eI^2);

% function vel = v(lambda)
% vel = -lambda*Lpinv*ek;
% end
% 
% function omegaT = wT(lambda)
% omegaT = norm([zeros(3) eye(3)]*v(lambda))*Ts/2;
% end

end

