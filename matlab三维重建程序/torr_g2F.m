%	By Philip Torr 2002
%	copyright Microsoft Corp.



% 
% %here p is the set of paramets such that
% g(1) = focal length
% g(2-3) sperical coordinates of rotation axis
% g(4) rotation angle
% g(5-6) is the translation vector

function f = torr_g2F(g,C)

%convert intrinsic and extinsics to a F matrix
C(3,3) = 1/g(1);
rot_axis = torr_sphere2unit([g(2) g(3)]);
tt = torr_sphere2unit([g(5) g(6)]);
rot_angle = g(4);

%Rogregues
II = [1 0 0; 0 1 0; 0 0 1];
AX = torr_skew_sym(rot_axis);
RR = cos(rot_angle) * II +sin(rot_angle) * AX + (1 - cos(rot_angle)) * rot_axis * rot_axis';

TX = torr_skew_sym(tt);
nnE = TX * RR;

F = inv(C') *  nnE * inv(C);
f = reshape(F',9,1);


