%	By Philip Torr 2002
%	copyright Microsoft Corp.
%script to test 1st order approx to the rotation matrix:
%it also checks that we are going between rotation matrices in the correct way

rotation_multplier = 20;



%Euler angles
theta = 1/360 * 2 * pi * rand * rotation_multplier;
n = 1/360 * 2 * pi * rand * rotation_multplier;
p = 1/360 * 2 * pi * rand * rotation_multplier;

R(1,1) = (1 - cos(p)) * cos(n)* ( cos(n) * cos(theta) + sin(theta) * sin(n) ) + cos(p)* cos(theta);
R(1,2) = (1 - cos(p))* cos(n) * ( sin(n) *cos(theta) - sin(theta) *cos(n) ) - cos(p) *sin(theta);
R(1,3) = sin(n) *sin(p);
R(2,1) = (1 - cos(p)) *sin(n)  *( cos(n) *cos(theta) + sin(theta)* sin(n) ) + cos(p)* sin(theta);
R(2,2) = (1 - cos(p)) *sin(n) * ( sin(n) *cos(theta) - sin(theta) *cos(n) ) + cos(p)* cos(theta);
R(2,3) = -cos(n) * sin(p);
R(3,1) = -sin(p) * ( sin(n) * cos(theta) - sin(theta) * cos(n));
R(3,2) = sin(p) * ( cos(n) * cos(theta) + sin(theta) * sin(n));
R(3,3) = cos(p);


%angles axis
rot_axis = [R(3,2)-R(2,3), R(1,3) - R(3,1), R(2,1) - R(1,2)];
rot_axis = rot_axis' /norm(rot_axis);
rot_angle = acos( (trace(R)-1)/2);

disp('rotation angle in degree')
 rot_angle * 360 /(2 * pi)

%Rogregues
II = [1 0 0; 0 1 0; 0 0 1];
AX = torr_skew_sym(rot_axis);
RR = cos(rot_angle) * II  + sin(rot_angle) * AX + (1 - cos(rot_angle)) * rot_axis * rot_axis';

%now switch to first order (fo) approx

sfo = 2 * tan ( 0.5 * rot_angle);
lfo = sfo * rot_axis;

Rfo = torr_skew_sym(lfo) + II;
Rfo = Rfo/norm(Rfo);
R
Rfo

disp('>> R * Rfo')

R * Rfo'

II - R * Rfo'


rot_axisfo = [Rfo(3,2)-Rfo(2,3), Rfo(1,3) - Rfo(3,1), Rfo(2,1) - Rfo(1,2)];
rot_axisfo = rot_axisfo/norm(rot_axisfo);
rot_anglefo = acos( (trace(Rfo)-1)/2);

%the axis is the same in the first order approx, but the angle is lower.

rot_axisfo
rot_anglefo * 360 /(2 * pi)
rot_axis
rot_angle  * 360 /(2 * pi)