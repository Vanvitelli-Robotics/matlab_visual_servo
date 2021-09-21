function DV_maj = buildFunDVmaj_lambda(ek,s_star,  Ts)

s = ek+s_star;
L = computeL(s);
Lpinv = pinv(L);
norm_eI = norm( L*Lpinv*ek );
norm_eN = norm(( eye(numel(ek)) -  L*Lpinv)*ek);

sinc_ = @(x) sinc(x/pi);
f = @(wT2) abs( exp(1i*wT2)*sinc_(wT2) -1 );

DV_maj =  @(lambda) -lambda*Ts*norm_eI*(2*norm_eI - f(wT(lambda))*norm_eI - f(wT(lambda))*norm_eN - lambda*Ts*norm_eI);

function vel = v(lambda)
vel = -lambda*Lpinv*ek;
end

function omegaT = wT(lambda)
omegaT = norm([zeros(3) eye(3)]*v(lambda))*Ts/2;
end

end

