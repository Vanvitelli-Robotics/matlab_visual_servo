function inteS = expSt_int(T,wx,wy,wz)
%EXPST_INT
%    INTES = EXPST_INT(T,WX,WY,WZ)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    01-Jun-2021 15:15:08

if norm([wx wy wz]) < 100*eps
   inteS = T*eye(3);
   return
end

t2 = wx.^2;
t3 = wx.^3;
t4 = wy.^2;
t5 = wy.^3;
t6 = wz.^2;
t7 = wz.^3;
t8 = (wx ~= 0.0);
t9 = (wy ~= 0.0);
t10 = (wz ~= 0.0);
t11 = -t2;
t12 = -t4;
t13 = -t6;
t14 = t2+t4+t6;
t15 = ((t8 | t9) | t10);
t16 = 1.0./t14;
t17 = sqrt(t14);
t25 = t11+t12+t13;
t18 = t17.^3;
t19 = 1.0./t17.^5;
t21 = T.*t17;
t29 = sqrt(complex(t25));
t20 = t18.*wz;
t22 = cos(t21);
t23 = sin(t21);
t24 = T.*t18.*wx.*wy;
t31 = 1.0./t29.^3;
t32 = T.*t29;
t26 = -t24;
t27 = t5.*t23.*wx;
t28 = t3.*t23.*wy;
t30 = t6.*t23.*wx.*wy;
t33 = sinh(t32);
t34 = t32./2.0;
t38 = t20.*t22;
t35 = sinh(t34);
t39 = t2.*t31.*t33;
t40 = t4.*t31.*t33;
t41 = t6.*t31.*t33;
t36 = t35.^2;
t42 = real(t39);
t43 = real(t40);
t44 = real(t41);
t37 = real(t36);
t45 = -t42;
t46 = -t43;
t47 = -t44;
if (t15)
    t0 = -t19.*(-t20+t26+t27+t28+t30+t38);
else
    t0 = NaN;
end
if (t15)
    t1 = -t19.*(t18.*wy-T.*t20.*wx+t7.*t23.*wx-t18.*t22.*wy+t3.*t23.*wz+t4.*t23.*wx.*wz);
else
    t1 = NaN;
end
if (t15)
    t8 = -t19.*(t20+t26+t27+t28+t30-t38);
else
    t8 = NaN;
end
if (t15)
    t9 = -t19.*(-t18.*wx-T.*t20.*wy+t18.*t22.*wx+t7.*t23.*wy+t5.*t23.*wz+t2.*t23.*wy.*wz);
else
    t9 = NaN;
end
inteS = reshape([t46+t47+T.*t2.*t16,t0,t1,t8,t45+t47+T.*t4.*t16,t9,real(t31.*t33.*wx.*wz)-t16.*t37.*wy.*2.0+T.*t16.*wx.*wz,real(t31.*t33.*wy.*wz)+t16.*t37.*wx.*2.0+T.*t16.*wy.*wz,t45+t46+T.*t6.*t16],[3,3]);
