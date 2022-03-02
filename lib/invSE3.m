function [a_T_b] = invSE3(b_T_a)
%invSE3 inverse of a homogeneous transformation matrix

a_R_b = b_T_a(1:3,1:3)';

a_T_b = [ a_R_b -a_R_b*b_T_a(1:3,4); 0 0 0 1 ];

end

