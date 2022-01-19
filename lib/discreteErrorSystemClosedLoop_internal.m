function ekp1 = discreteErrorSystemClosedLoop_internal(lambdaT, ek, L, Lpinv, Ds_stark, forward_action_enabled )

% function ekp1 = discreteErrorSystemClosedLoop_internal_lambda(lambdaT, ek, Ts, L, Lpinv, Ds_stark, forward_action_enabled )

% if forward_action_enabled
%     vel = Lpinv*( Ds_stark/Ts - lambda*ek );
% else
%     vel = - lambda*Lpinv*ek;
% end
% 
% intSbar = intS_bar(vel(4:6), Ts, numel(ek)/3);
% 
% ekp1 = ek + intSbar*L*vel - Ds_stark;

% ekp1 = ek - integralExp_lambaT(lambdaT,unitGainRotVel)*eI + ;

N_features = numel(ek)/3;

if forward_action_enabled
    
    if lambdaT < 10*eps
        unitStepForwardActionVel = Lpinv*Ds_stark;
        unitStepForwardActionRotVel = unitStepForwardActionVel(4:6);
        INT = matrixBar(integralOfConstAxR(-unitStepForwardActionRotVel,1),N_features);
        ekp1 = ek - Ds_stark + INT*L*unitStepForwardActionVel;
    else
        unitGainVel = Lpinv*ek;
        unitStepForwardActionVel = Lpinv*Ds_stark;
        normalizedVel = unitStepForwardActionVel/lambdaT - unitGainVel;
        normalizedRotVel = normalizedVel(4:6);
        INT = matrixBar(integralOfConstAxR(-normalizedRotVel,lambdaT),N_features);
        ekp1 = ek - Ds_stark + INT*L*normalizedVel;
    end
    
else
   unitGainVel = Lpinv*ek;
   unitGainRotVel = unitGainVel(4:6);
   INT = matrixBar(integralOfConstAxR(unitGainRotVel,lambdaT),N_features);
   ekp1 = ek - INT*L*unitGainVel - Ds_stark;
end

end

