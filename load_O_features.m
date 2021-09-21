% O = Object
% C = camera
% W = space/world

% features w.r.t. object frame

O_features = [ ...
    [ 0; 0;  0], ...
    ... [.5; 0;  0], ...
    [ 1; 0;  0], ...
    ... [ 0; 0; .5], ...
    ... [.5; 0; .5], ...
    ... [ 1; 0; .5], ...
    ... [ 0; 0;  1], ...
    ... [.5; 0;  1], ...
    [ 1; 0;  1] ...
    ];
O_T_C_desired = SE3(rotx(90), [.5, .5, .5]');

% O_features = [ ...
%     [ 0; 0;  0], ...
%     [ 0; 0;  1], ...
%     [ 0; 1; 0], ...
%     [ 0; 1; 1], ...
%     ];
% O_features = [ ... allineate con origine T*
%     [ 0; -1;  .5], ...
%     [ 0; 0;  .5], ...
%     [ 0; 1; .5], ...
%     ];
% O_features = [ ... allineati ma non dipendenti
%     [ -1; 0;  .5], ...
%     [ 0; 0;  .75], ...
%     [ 1; 0; 1], ...
%     ...[ 0; 1;  .5+(.25/2*1)], ...
%     ];
% O_T_C_desired = SE3(rotx(90)*rotx(0), [0, 2, .5]');