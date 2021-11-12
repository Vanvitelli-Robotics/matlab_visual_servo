quat = out.quaternion.Data;
pos = out.position.Data;

R0 = quat2rotm(quat(1,:));
T0 = [R0, pos(1,:)'; 0 0 0 1];
DT0 = inv(W_T_C_desired.double)*T0;

Rend = quat2rotm(quat(end,:));
Tend = [Rend, pos(end,:)'; 0 0 0 1];
DTend = inv(W_T_C_desired.double)*Tend;

for i=1:size(quat,1)
    R__ = quat2rotm(quat(i,:));
    T__ = [R__, pos(i,:)'; 0 0 0 1];
    SE3_VEC(i) = SE3( inv(W_T_C_desired.double)*T__);
end

figure(103)
hold on
trplot(eye(4),'color','k')
trplot(DT0,'color','b')
trplot(DTend,'color','r')
SE3_VEC_ = SE3_VEC(1:300:end);
SE3_VEC_.animate()

% plot3([0 axang(1)],[0 axang(2)],[0 axang(3)],'k');