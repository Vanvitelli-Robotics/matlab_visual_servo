clear all
close all

addpath('../lib')


figure(1)
hold on
grid on
xlabel('||e||')
ylabel('alpha')
ax_e = gca;
l_e = plot(ax_e,nan,nan,'r.');
figure(2)
hold on
grid on
xlabel('||eI||')
ylabel('alpha')
ax_eI = gca;
l_eI = plot(ax_eI,nan,nan,'r.');
figure(22)
hold on
grid on
xlabel('||eN||')
ylabel('alpha')
ax_eN = gca;
l_eN = plot(ax_eN,nan,nan,'r.');
figure(3)
hold on
grid on
xlabel('theta deg')
ylabel('alpha')
ax_th = gca;
l_th = plot(ax_th,nan,nan,'r.');
figure(4)
hold on
grid on
xlabel('eN')
ylabel('eI')
ax_eNeI = gca;
l_eNeI = plot(ax_eNeI,nan,nan,'r.');

n_plot = 100;

%% generate sstar
N = 10;
norm_sstar = 1; % unitario
s_star = rand(3,N)*norm_sstar;

[eq1, eq2, eq3] = computeEqPoints(s_star);
eD = min([norm(eq1), norm(eq2), norm(eq3)]);
hold(ax_e,'on');
plot(ax_e,[eD eD],[1 3],'b');
hold(ax_e,'off');
hold(ax_th,'on');
plot(ax_th,[180 180],[1 3],'b');
hold(ax_th,'off');
circle(ax_eNeI,0,0,eD,0:0.01:(pi/2),'k');

%% loop

for std_p_mul=[1, .75, .5, .25, .1]
disp('0');
for std_th_mul=[1, .75, .5, .25, .1]
disp('1');
    
mean_r = 0;
std_r = 1;
mean_th = 0;
std_th = deg2rad(180)*std_th_mul;
mean_p = 0;
std_p = eD*std_p_mul;

for i=1:30000

    % random axis
    r = unit(mean_r + std_r*randn(3,1));
    % random angle
    theta = mean_th + std_th*randn;
    % random vector
    p = mean_p + std_p*randn(3,1);

    R = angvec2r(theta,p);

    T = SE3([R, p; 0 0 0 1]);

    s = homtrans(T, s_star);
    e = s(:)-s_star(:);
    L = computeL(s);
    Lpinv = pinv(L);

    eI = L*Lpinv*e;
    eN = e-eI;

    nE = norm(e);
    nEI = norm(eI);
    nEN = norm(eN);
    alph = nE/nEI;
    
    l_e.XData(end+1) = nE;
    l_e.YData(end+1) = alph;
    
    l_eI.XData(end+1) = nEI;
    l_eI.YData(end+1) = alph;
    
    l_eN.XData(end+1) = nEN;
    l_eN.YData(end+1) = alph;
    
    l_th.XData(end+1) = abs(rad2deg(theta));
    l_th.YData(end+1) = alph;
    
    l_eNeI.XData(end+1) = nEN;
    l_eNeI.YData(end+1) = nEI;

if mod(i,n_plot) == 0
drawnow
end

end
end
end

function h = circle(ax,x,y,r,th,style)
hold(ax,'on');
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(ax,xunit, yunit,style);
hold(ax,'off');
end