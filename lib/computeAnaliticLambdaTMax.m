function lambdaT_max = computeAnaliticLambdaTMax(e,L)

Lpinv = pinv(L);
eI = L*Lpinv*e;

normEI = norm(eI);
if(normEI < 10*eps)
    alph = 1;
else
    alph = (norm(e))/normEI;
end

lambdaT_max = 2/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv*e ) );
% lambda_max = inf;
% lambda_max = (2/Ts)/(1  + alph * norm( [zeros(3) eye(3)]*Lpinv)*norm(e) );

end

