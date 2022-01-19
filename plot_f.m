init;

sstar = C_features_desired(:);
 s = s0(:);
fs = ['o' '*' '.'];

% for i=0:(numel(s)/3)-1
%    s_ = s((3*i)+1:((3*i+3)));
%    sstar_ = sstar((3*i)+1:((3*i+3)));
%    
%    figure(1)
%    hold on
%    plot3(s_(1),s_(2),s_(3),['r', fs(i+1)]);
%    plot3(sstar_(1),sstar_(2),sstar_(3),['b', fs(i+1)]);
%    
% end

grid on

%norms
ne_ = zeros(3,1);
N = numel(C_features_desired)/3;
for i=1:3
[rotax] = calcEQrotax(C_features_desired,i);
rotax = unit(rotax);
rotang = deg2rad(180);
R_ = angvec2r(rotang,rotax);
t_ = (eye(3)-R_)*sum(C_features_desired,2)/size(C_features_desired,2);
% T_ = inv([R_, t_; 0 0 0 1]);
T_ = [R_, t_; 0 0 0 1];
R_BAR = kron(eye(N),T_(1:3,1:3));
t_bar = kron(ones(N,1),T_(1:3,4));
s_ = R_BAR*C_features_desired(:) + t_bar;
e_ = s_ - C_features_desired(:);
ne_(i) = norm(e_);
end


ne_