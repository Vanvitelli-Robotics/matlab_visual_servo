function lambdaT_max = computeAnaliticLambdaTMax(e,L,Dsstar)

Lpinv = pinv(L);
eI = L*Lpinv*e;

normEI = norm(eI);
if(normEI < 10*eps)
    alph = 1;
else
    alph = (norm(e) + norm(Dsstar))/normEI;
end

% lambdaT_max = (2 - alph*norm([zeros(3) eye(3)]*Lpinv*Dsstar))/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv*e ) );
lambdaT_max = 0.5* 2/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv*e ) );
% lambda_max = inf;
% lambda_max = (2/Ts)/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv)*norm(e) );

MIN = 0.002;
MAX = 0.005;
valMIN = 0.1; % TS
valMAX = 1;
rmse = sqrt(norm(e)^2/(numel(e)/3));

if lambdaT_max < MAX
    lambdaT_max = 1;
end

if rmse > MAX
    val = 1;
elseif rmse < MIN
    val = valMIN;
else
    val = (valMIN-valMAX)/(MIN-MAX) * rmse - (valMIN-valMAX)/(MIN-MAX) * MAX + valMAX;
end
lambdaT_max = lambdaT_max*val;

return
N = 0.001;
rmse = sqrt((norm(e)^2)/(numel(e)/3));
if rmse < N
    lambdaT_max = 0;
    return
end
if rmse < 3*N
    lambdaT_max = (1/(3*N-N))*(lambdaT_max-N);
    return
end

end

