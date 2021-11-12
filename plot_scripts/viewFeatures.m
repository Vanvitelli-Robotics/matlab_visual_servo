figure(12)
hold on

opts = {'b*','b+','bo'};

plot_W_features(W_features,opts);

trplot(W_T_C_desired,'color','k')
trplot(W_T_C_0,'color','b')

% s = out.s.Data;
s_star = C_features_desired(:);
s0 = C_features_0(:);%s(1,:);

figure(13)
hold on
plot_W_features(s_star,{'k*','k+','ko'});
plot_W_features(s0,{'b*','b+','bo'});
xlabel('x')
ylabel('y')
zlabel('z')



function plot_W_features(W_features,opts)
    s = W_features(:);
    j = 1;
    for i=1:3:numel(s)
        indx = i:(i+2);
        plot3(s(indx(1)),s(indx(2)),s(indx(3)),opts{j});
        j = j+1;
    end
end