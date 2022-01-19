addpath('../')

init2


Lsstar = computeL(s_star);
Lshat = computeL(shat);

a = -1e-16; b = 1e-16;
eps_ = a + (b-a).*rand(6,1);

s__ = Lshat*eps_ + shat(:);
L__ = computeL(s__);

-eps_'*(Lshat'*Lshat)*inv(L__'*L__)*Lsstar'*Lshat*eps_

-eig(Lsstar'*Lshat)
