[s_eq1, s_eq2, s_eq3, t_eq1, R_eq1, t_eq2, R_eq2, t_eq3, R_eq3, r_eq1, r_eq2, r_eq3] = computeEqPoints(C_features_desired);
e_eq1 = s_eq1 - C_features_desired;
e_eq2 = s_eq2 - C_features_desired;
e_eq3 = s_eq3 - C_features_desired;

e = out.e.Data;
eI = out.eI.Data;
t = out.e.Time;

nEN = zeros(1,numel(t));
nEI = nEN;

for i=1:numel(t)
    nEN(i) = norm(e(i,:)-eI(i,:));
    nEI(i) = norm(eI(i,:));
end

figure(35),hold on,
plot(norm(e_eq1(:))*[1 1], [0 1],'k');
plot(norm(e_eq2(:))*[1 1], [0 1],'k');
plot(norm(e_eq3(:))*[1 1], [0 1],'k');

eGamma = min([norm(e_eq1(:)), norm(e_eq2(:)), norm(e_eq3(:))]);
h = circle(gca,1/2 * eGamma,0,1/2,0:0.01:pi,eGamma,'k--');
hold on,

plot(nEN,nEI)

% return;

sp = out.sp.Data;

nEIp = [];
nENp = [];
for i=1:numel(t)
    ep = sp(i,:)' + shat(:) - s_star(:);
    Lshat = computeL(shat);
%     Lshat = computeL(e(i,:)'+s_star(:));
    epI = Lshat*pinv(Lshat)*ep;
    nEIp(i) = norm(Lshat*pinv(Lshat)*ep);
    nENp(i) = norm(ep-epI);
end
figure(30),hold on,
plot(nENp,nEIp,'--')

function h = circle(ax,x,y,r,th,gain,style)
hold(ax,'on');
xunit = r * cos(th)*gain + x;
yunit = r * sin(th)*gain + y;
h = plot(ax,xunit, yunit,style);
hold(ax,'off');
end