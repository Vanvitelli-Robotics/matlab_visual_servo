function [p,p_dot] = trapezVelTraj(t,pi,pf,vmax,ai,af,ti)
%trapezVelTraj trapezoidal velocity scalar trajectory

Dt = t-ti;
Dp_max = pf - pi;
direction = 1;
if Dp_max < 0
    direction = -1;
    Dp_max = abs(Dp_max);
end

if Dt <= 0
   p = pi;
   p_dot = 0;
   return;
end

ta_max = vmax/ai;
td_max = vmax/af;

normal_case = ta_max*vmax/2 + td_max*vmax/2 <= Dp_max;

if normal_case
    if Dt <= ta_max
        p_dot = ai*Dt;
        Dp = .5*p_dot*Dt;
        p_dot = direction*p_dot;
        p = pi + (direction*Dp);
        return;
    end
    tc = (Dp_max/vmax) - .5*(ta_max+td_max);
    if Dt <= (ta_max + tc)
        DDt = Dt - ta_max;
        p_dot = vmax;
        Dp = (.5*vmax*ta_max) + (DDt*vmax) ;
        p_dot = direction*p_dot;
        p = pi + (direction*Dp);
        return;
    end
    if Dt <= (ta_max + tc + td_max)
        DDt = Dt - ta_max - tc;
        p_dot = (vmax - (af*DDt));
        Dp = (.5*vmax*ta_max) + (tc*vmax) + (DDt*p_dot) + (.5*DDt*(vmax-p_dot));
        p_dot = direction*p_dot;
        p = pi + (direction*Dp);
        return;
    end
    p_dot = 0;
    p = pf;
    return;
else
    td = sqrt(2*ai*Dp_max/((af^2)+(ai*af)));
    ta = td*af/ai;
    if Dt < ta
        p_dot = ai*Dt;
        Dp = .5*p_dot*Dt;
        p_dot = direction*p_dot;
        p = pi + (direction*Dp);
        return;
    end
    if Dt < (ta + td)
        DDt = Dt - ta;
        p_dot = ai*ta - af*DDt;
        Dp = (.5*(ta^2)*ai) + (DDt*p_dot) + (.5*DDt*((ai*ta)-p_dot));
        p_dot = direction*p_dot;
        p = pi + (direction*Dp);
        return;
    end
    p_dot = 0;
    p = pf;
    return;
end

end

