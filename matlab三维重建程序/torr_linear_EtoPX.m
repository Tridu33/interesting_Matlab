%	By Philip Torr 2002
%	copyright Microsoft Corp.

%takes an essential matrix and a set of corrected matches, and outputs projection matrices, 3D points etc
%all via linear estimation; need camera calibration matrix too

function [P1,P2,R,t,rot_axis,rot_angle,g] = torr_linear_EtoPX(E,matches,C,m3)


%stage 1 generate twisted pairs etc
[U,S,V] = svd(E);
%note that there is a one p[arameter family of SVD's for E

if abs(S(3,3)) > 0.00001
    error('E must be rank 2 to self calibrate');
end

if abs(S(1,1) - S(2,2)) > 0.00001
    error('E must have two equal singular values');
end



%use Hartley matrices:
W = [0 -1 0; 1 0 0; 0 0 1];
Z = [0 1 0; -1 0 0; 0 0 0];

Tx = U * Z * U';

R1 = U * W * V';
R2 = U * W' * V';
R1 = R1 * sign(det(R1)) * sign(det(C));
R2 = R2 * sign(det(R2)) * sign(det(C));



%the left epipole is, which gives the direction of translation
u3 = U(:,3);
%such that u3' * E = 0,


%next establish the four possible camera matrix pairs as points out in Maybank, Hartley & zisserman etc
%first camera is 3x4 at origin of the world system.
P1 = [C'; 0,0,0]';

%given this there are four choices for the second, we normalize them so that the
%determinant of the first 3x3 is greater than zero, this is useful for determining chierality later
P21 = C * [ R1'; u3']';
P22 = C * [ R1'; -u3']';

P23 = C * [ R2'; u3']';
P24 = C * [ R2'; -u3']';

%next we take one point to determine the chierality of the camera


X1 = torr_triangulate(matches, m3, P1, P21);
X2 = torr_triangulate(matches, m3, P1, P22);
X3 = torr_triangulate(matches, m3, P1, P23);
X4 = torr_triangulate(matches, m3, P1, P24);

%next reproject and compare with the images
%the chieral constraint is sign(det M) * sign (third homog coord of reprojected image) * sign (fourth homog coord X)
% to make sure we dont get any outliers we average the inequalities over all the points, ones with a bad sign
% can later be removed as outleirs.
%we want chieral for both cameras to be positive

ax1 = P1 * X1;
%ax1 = ax1 *m3/ax1(3)


ax2 = P1 * X2;
%ax2 = ax2 *m3/ax2(3)

ax3 = P1 * X3;
%ax3 = ax3 *m3/ax3(3)

ax4 = P1 * X4;
%ax4 = ax4 *m3/ax4(3);


bx1 = P21 * X1;
%bx1 = bx1 *m3/bx1(3)

bx2 = P22 * X2;
%bx2 = bx2 *m3/bx2(3)

bx3 = P23 * X3;
%bx3 = bx3 *m3/bx3(3)

bx4 = P24 * X4;
%bx4 = bx4 *m3/bx4(3);

chieral1 = (sign(ax1(3,:) ) .* sign (X1(4,:))) +  (sign(bx1(3,:) ) .* sign (X1(4,:)));
chieral2 = (sign(ax2(3,:) ) .* sign (X1(4,:))) +  (sign(bx2(3,:) ) .* sign (X2(4,:)));
chieral3 = (sign(ax3(3,:) ) .* sign (X1(4,:))) +  (sign(bx3(3,:) ) .* sign (X3(4,:)));
chieral4 = (sign(ax4(3,:) ) .* sign (X1(4,:))) +  (sign(bx4(3,:) ) .* sign (X4(4,:)));


chieral_sum = [sum(chieral1) sum(chieral2) sum(chieral3) sum(chieral4)];

[max_ch correct_interpretation] = max(chieral_sum);

switch correct_interpretation
case 1
    R = R1;
    t = u3;
    P2 = P21;
    
case 2
    R = R1;
    t = -u3;
    P2 = P22;
    
case 3
    R = R2;
    t = u3;
    P2 = P23;
    
case 4
    R = R2;
    t = -u3;
    P2 = P24;
end

%next recover the parameters of the rotation...
% [VR,DR] = eig(R);
% 
% dd = [DR(1,1), DR(2,2), DR(3,3)];
% [Y Index] = find(dd==1);
% 
% %determine axis of rotation
% axis = VR(:,Index(1));
rot_axis = [R(3,2)-R(2,3), R(1,3) - R(3,1), R(2,1) - R(1,2)];
rot_axis = rot_axis /norm(rot_axis);
rot_angle = acos( (trace(R)-1)/2);

[a b] = torr_unit2sphere(rot_axis);
[ta tb] = torr_unit2sphere(t);

%put together intrinisc and extrinsic parameters
% 
% %here p is the set of paramets such that
% g(1) = focal length
% g(2-3) rotation axis
% g(4) rotation angle
% g(5-6) translation direction
g(1) = 1/C(3,3);
g(2) = a;
g(3) = b;
g(4) = rot_angle;
g(5) = ta;
g(6) = tb;


% 
% CCC = C;
% %convert intrinsic and extinsics to a F matrix
% C(3,3) = 1/g(1);
% rot_axis2 = torr_sphere2unit([g(2) g(3)]);
% tt = torr_sphere2unit([g(5) g(6)]);
% rot_angle2 = g(4);
% 
% %Rogregues
% II = [1 0 0; 0 1 0; 0 0 1];
% AX = torr_skew_sym(rot_axis2);
% 
% %note -sin produce RR'
% RR = (cos(rot_angle2) * II  +sin(rot_angle2) * AX + (1 - cos(rot_angle2)) * rot_axis2 * rot_axis2');
% 
% TX = torr_skew_sym(tt);
% nnE = TX * RR;
% 
% %F = inv(C') *  nnE * inv(C);
% F = inv(C')  * nnE * inv(C);
% f = reshape(F,9,1);





