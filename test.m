clear all, %close all

pi = 1; pf = 100; vmax = 10; ai=10; af = 10; ti = 1; tt=(0:0.01:20);
p = zeros(size(tt)); pdot = p;
for i=1:numel(p)
t = tt(i);
[pp,pp_dot] = trapezVelTraj(t,0,1,vmax,ai,af,ti);pp = pp*(pf-pi) + pi;
% [pp,pp_dot] = trapezVelTraj(t,pi,pf,vmax,ai,af,ti);

p(i) = pp; pdot(i)=pp_dot;
end
Z = trapz(tt,pdot) + pi;
figure(1),hold on,plot(tt,p)
figure(2),hold on,plot(tt,pdot,'-*')