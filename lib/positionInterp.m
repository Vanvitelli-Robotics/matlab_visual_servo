function [pt, ptdot] = positionInterp(t, pi, pf, scalarTraj)
%POSITIONINTERP Summary of this function goes here
%   Detailed explanation goes here

[straj, strajdot] = scalarTraj(t);

pt = pi + (straj * (pf - pi));

ptdot = strajdot * (pf - pi);
end

