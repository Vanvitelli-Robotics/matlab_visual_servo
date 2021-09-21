function DV = buildFunDV_lambda(ek,s_star,Ts,Ds_stark,forward_action_enabled)

if(nargin < 5 || isempty(forward_action_enabled))
    forward_action_enabled = true;
end
if(nargin < 4 || isempty(Ds_stark))
    Ds_stark = 0;
    forward_action_enabled = false;
end

s = ek+s_star;
L = computeL(s);
Lpinv = pinv(L);

f_ekp1 = @(lambda)discreteErrorSystemClosedLoop_internal_lambda(...
    lambda,...
    ek,...
    Ts,...
    L,...
    Lpinv,...
    Ds_stark, ...
    forward_action_enabled);

DV = @(lambda) norm(f_ekp1(lambda))^2 - norm(ek)^2;

end

