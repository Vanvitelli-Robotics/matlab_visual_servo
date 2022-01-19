w_q_c = out.quaternion.Data;
w_p_c = out.position.Data;
t = out.quaternion.Time;

W_Q_C_desired = UnitQuaternion(W_T_C_desired);

F = UnitQuaternion(rotm2quat(W_T_C_desired.R));
% oldqquat = [1 0 0 0];
clear ang vec pos
for i=1:size(w_q_c,1)
   w_qq_c = w_q_c(i,:); 
%    w_qq_c = quat_continuity(w_qq_c, oldqquat);
%    oldqquat = w_qq_c;
   W_Q_C = UnitQuaternion(w_qq_c);
   c_Q_cd = inv(W_Q_C)*W_Q_C_desired;
%    Cd_Q_C = inv(W_Q_C_desired)*W_Q_C;
%    ang(:,i) = (Cd_Q_C.torpy()');
   [ang_,vec_] = c_Q_cd.toangvec;
   ang(:,i) = abs(wrapToPi(-ang_));
   vec(:,i) = -vec_(:);
   pos(i) = norm(w_p_c(i,:)' - transl(W_T_C_desired)');
end

figure,plot(t, ang, t,pos, ...
    t,nEI, t,nEN )

function Q = quat_continuity(Q, oldQ)
  if ((Q(2:end) * oldQ(2:end)') < -0.01)  
    Q = -Q;
  end
  end