
init

[eq1, eq2, eq3] = computeEqPoints(C_features_desired);
eD = min([norm(eq1), norm(eq2), norm(eq3)]);
eD

% a = -(eG - (17/2)*T*sm);
% b = (17/4)*T*eG + 2*T^2*sm;
% c = T^2*eG;
%     
% r = roots([a b c]);
%     
% r = r(r>0);
%     
% if( numel(r) == 1)
%     y(end+1) = r;
% else
%     y(end+1) = nan;
% end

Cd_T_C0 =  inv(C0_T_Cdesired);
axang = rotm2axang(Cd_T_C0.R);
r = axang(1:3)';
th = axang(end);
p = Cd_T_C0.t;

v = zeros(numel(s0));

s00 = reshape(s0,3,numel(s0)/3);

out = zeros(size(s00));
for i=1:size(s00,2)
    
    s0_ = s00(:,i);
    
    out(:,i) = skew(-s0_)*r*th + p;
    
end

beta = 0.06;% 0.1724;% 0.104; %0.1724;
eG = eD;

norm(out(:))*15/8*(beta/(eG))