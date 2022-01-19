
% sdot_m = .235*4;

s_dot_m_v = 0:0.1:1;

y = [];
for sdot_m = s_dot_m_v

m = 0.54;
eG = eD;
Ds = Ts*sdot_m;

a = 2*m*eG;
b = -m;
c = 4*Ds-m*eG;
d = Ds/4 + 2*Ds^2;
e = Ds^2*eG;

r = roots([a b c d e])
r = r(isreal(r));
r = r(r>0 & r<eG);
numel(r)
if numel(r) == 1
    y(end+1)=r;
else
    y(end+1)=nan;
end

end

figure
plot(s_dot_m_v,y);
grid on