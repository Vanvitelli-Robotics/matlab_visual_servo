function [Qt, wt, deltaAng] = quatInterp(t, initial_quat, final_quat, scalarTraj)
%POSITIONINTERP quaternion trajectory generator

[rot_axis, deltaAng] = calcAxis(final_quat, initial_quat);

[DQ, wt] = getDeltaQuat(t, rot_axis, deltaAng, scalarTraj);

Qt = quatProd( ...
    DQ, ...
    initial_quat);

end

function q = quatProd(q1,q2)
s1 = q1(1);
v1 = q1(2:4);
s2 = q2(1);
v2 = q2(2:4);
q = [s1*s2-v1*v2.' s1*v2+s2*v1+cross(v1,v2)];
end

function q = quatInv(q1)
q = [q1(1) -q1(2:4)];
end

function [rot_axis, angf] = calcAxis(final_quat, initial_quat)

  Delta_Q = quatProd( final_quat,  quatInv(initial_quat) );
  [angf, rot_axis] = toangvec(Delta_Q);
  if(norm(rot_axis)<10*eps)
      rot_axis = [1 0 0];
  end

end

function [theta,n] = toangvec(q)
            
            % compute the angle and vector for each quaternion
            if norm(q(2:4)) < 10*eps
                % identity quaternion, null rotation
                theta = 0;
                n = [0 0 0];
            else
                % finite rotation
                n = unit(q(2:4));
                theta = 2*atan2( norm(q(2:4)), q(1));
            end
 end

function [DQ, w] = getDeltaQuat(t, rot_axis, deltaAng, scalarTraj)

  if ( norm(rot_axis) == 0)
    DQ = [1 0 0 0];
    w = [0; 0; 0];
    return
  
  else
    [theta, w_] =  scalarTraj(t,deltaAng);
    [DQ] = angvec( ...
        theta,...
        rot_axis);
    w = w_*unit(rot_axis(:));
    return
  end
end

function uq = angvec(theta, v)             
            uq_s = cos(theta/2);
            uq_v = sin(theta/2)*unit(v(:)');
  uq = [uq_s, uq_v];
 end
