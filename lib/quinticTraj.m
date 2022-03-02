function [s, sdot] = quinticTraj(t,pi,pf,ti,tf)
%quinticTraj quintic poly scalar trajectory

dur = tf-ti;
t_2 = (dur^2);
t_3 = (dur^3);
t_4 = (dur^4);
t_5 = (dur^5);

vf = 0; vi = 0; aci=0; acf=0;

% Construct inverse of A ( A*poly_coeff = B )
A_inv = [(6.0 / t_5), (-3.0 / t_4), (1.0 / (2.0 * t_3));
    (-15.0 / t_4), (7.0 / t_3), (-1.0 / t_2);
    (10.0 / t_3), (-4.0 / t_2), (1.0 / (2.0 * dur))];
%Construct B
B = [(pf - pi - vi * dur - (aci / 2.0) * t_2), (vf - vi - aci * dur), (acf - aci)]';

% Calculate poly coeff
poly_coeff = [A_inv * B; aci/2;  vi; pi; ];
poly_coeff = poly_coeff';

%calculate coeff of dp and ddp as polydiff
vel_poly_coeff = polydiff(poly_coeff);
acc_poly_coeff = polydiff(vel_poly_coeff);

if (t <= ti)
    s = pi;
    sdot = 0;
    return
elseif (t >= tf)
    s = pf;
    sdot = 0;
    return
else
  s = polyval(poly_coeff, t - ti);
  sdot = polyval(vel_poly_coeff, t - ti);
  return
end

end

