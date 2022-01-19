function out = integralOfConstAxR(w,T)
% integral of rotation matrix with const axis, w rotation axis, ||w*T||
% total rotation angle

nW = norm(w);
wT = nW*T;
if wT < 10*eps
    out = T*eye(3);
    return;
end

SS = skew(unit(w));

out = eye(3);
out = out + ((1-cos(wT))/wT)*SS;
out = out + ((wT - sin(wT))/wT)*SS*SS;
out = out*T;

end

