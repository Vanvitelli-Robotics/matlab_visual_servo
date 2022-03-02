function [pt, ptdot] = positionInterp(t, pi, pf, scalarTraj)
%POSITIONINTERP position trajectory generator

[straj, strajdot] = scalarTraj(t);

pt = pi + (straj * (pf - pi));

ptdot = strajdot * (pf - pi);
end

