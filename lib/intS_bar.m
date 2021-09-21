function intSbar = intS_bar(w, Ts, N_features)
    intSbar = kron(eye(N_features), expSt_int(Ts,-w(1),-w(2),-w(3)));
end