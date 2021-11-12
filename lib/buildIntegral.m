close all
clear all

%% Build integral int 0 to T of expm(skew(w)t) dt

syms t T wx wy wz real

w = [wx; wy; wz];

inteS = simplify(real(int(expm(skew(w)*t),t,0,T)));

matlabFunction(inteS,'File','computeIntegralExpSkew');

%% test
w = [0.1; 0.1; 0.1];
T = 0.1;
Qk=integral(@(t) expm(skew(w).*t),0,T, 'ArrayValued', true);
Qk - computeIntegralExpSkew(T,w(1),w(2),w(3))

