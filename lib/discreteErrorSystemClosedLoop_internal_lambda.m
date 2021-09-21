function ekp1 = discreteErrorSystemClosedLoop_internal_lambda(lambda, ek, Ts, L, Lpinv, Ds_stark, forward_action_enabled )

if forward_action_enabled
    vel = Lpinv*( Ds_stark/Ts - lambda*ek );
else
    vel = - lambda*Lpinv*ek;
end

intSbar = intS_bar(vel(4:6), Ts, numel(ek)/3);

ekp1 = ek + intSbar*L*vel - Ds_stark;

end

