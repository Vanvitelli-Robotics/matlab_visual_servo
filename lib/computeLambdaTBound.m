function max_lambdaT = computeLambdaTBound(unit_gain_v_closed_loop, TForwardVel, max_vT)

if norm(unit_gain_v_closed_loop) < 10*eps
    if norm(TForwardVel) > max_vT^2
        disp("Ds_star too big and ek=0");
        max_lambdaT = 0; % convention
        return;
    end
    max_lambdaT = inf;
    return;
end 

if norm(TForwardVel) < 10*eps
    max_lambdaT = max_vT/norm(unit_gain_v_closed_loop);
    return;
end

a = norm(unit_gain_v_closed_loop)^2;
b = -TForwardVel'*unit_gain_v_closed_loop;
c = norm(TForwardVel)^2 - max_vT^2;
DELTA = b^2 - 4*a*c;
if DELTA <= 0
   disp("Ds_star too big and DELTA<=0");
   max_lambdaT = 0; %convention
else
    solution = roots([a b c]);
    sol_1 = real(solution(1));
    sol_2 = real(solution(2));
    if sol_1*sol_2 <= 0
        % opposite sign
        max_lambdaT = max(sol_1,sol_2);
        return;
    else
        % same sign
        if sol_1 < 0
            % negative => no solition
            disp("Ds_star too big and solutions<0");
            max_lambdaT = 0; %convention
            return;
        else
            % positive => solution between lambda_min, lambda_max
            % I will choose lambda_max but here we still have a warning
            disp("Ds_star too big and solutions>0");
            max_lambdaT = max(sol_1,sol_2);
            return;
        end
    end
end

end

