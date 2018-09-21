%	By Philip Torr 2002
%	copyright Microsoft Corp.
%generates a set of point matches + their F matrix!@
%torr_gen_2view_matches.m
%we need to make sure that the object isnt too affine
function [true_F,x1,y1,x2,y2,nx1,ny1,nx2,ny2,true_C,true_R,true_TX, true_E, true_X, true_t] = ...
    torr_gen_2view_matches(foc, no_matches, noise_sigma, translation_mult, translation_adder, ...
    rotation_multplier, min_Z,Z_RAN,m3, other_parameters)

if nargin == 0
    %default values
    m3 = 256.0; %third homogeneous coordinate
    
    %focal length
    foc = m3 *3;
    %number of matches desired
    no_matches = 100;
    % noise added to each point
    noise_sigma = 1;
    
    %translation between translation_adder and translation_mult + translation_adder, uniformly distributed.
    translation_mult = foc * 2;
    translation_adder = 0;
    
    %max number of degrees to rotate
    rotation_min = 5; %min no of degrees to rotate unless pure_translation == true
    rotation_multplier = 8;
    
    %number of focal lengths nearest and furthest points are from camera one, all other points uniformly
    % distributed between these two values
    min_Z = 3;
    Z_RAN = 10;
end


%not yet implmented
if nargin < 10
    pure_translation = 0;
    pure_rotation = 0;
    orthographic = 0;
else
    pure_translation = other_parameters(1);
    pure_rotation = other_parameters(2);
    orthographic = other_parameters(3);
end
    

C = eye(3);
C(1,3) = 0;
C(2,3) = 0;
C(3,3) = 1/foc;

R = eye(3);
t = rand(3,1);
t = t * (translation_mult *norm(t)) +translation_adder;
true_t = t;
T = [0 -t(3) t(2); t(3) 0 -t(1); -t(2) t(1) 0];

%
% rot_axis = rand(3,1);
% rot_axis = rot_axis/norm(rot_axis);
% rot_angle = 1/360 * 2 * pi * rand * rotation_multplier + rotation_min;
% %Rogregues
% II = [1 0 0; 0 1 0; 0 0 1];
% AX = torr_skew_sym(rot_axis);
% R = cos(rot_angle) * II +sin(rot_angle) * AX + (1 - cos(rot_angle)) * rot_axis * rot_axis';


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

%R * R'
%R' * R

perfect_matches = rand(no_matches,4);
noisy_matches = rand(no_matches,4);
m1 = rand(3,no_matches);
m2 = rand(3,no_matches);

x1 = rand(no_matches,1);
x2 = rand(no_matches,1);
y1 = rand(no_matches,1);
y2 = rand(no_matches,1);

X = rand(3,no_matches);

%noisy data:----
nx1 = rand(no_matches,1);
nx2 = rand(no_matches,1);
ny1 = rand(no_matches,1);
ny2 = rand(no_matches,1);

for(i = 1:no_matches)
    X(3,i) = min_Z * foc + Z_RAN * foc * X(3,i);
    X(1,i) = (X(1,i) * 512 -256 ) *X(3,i)/foc;
    X(2,i) = (X(2,i) * 512 -256 ) * X(3,i)/foc;
end


m1 = C *X;
m2 = R *X;
m2 = m2 + t * ones(1,no_matches);
m2 = C * m2;
%   m2 = C * ( R *X + t);

%for(i = 1:no_matches)
x1 = (m1(1,:)./m1(3,:))';
y1 = (m1(2,:)./m1(3,:))';
x2 = (m2(1,:)./m2(3,:))';
y2 = (m2(2,:)./m2(3,:))';


perfect_matches(:,1) = x1(:);
perfect_matches(:,2) = y1(:);
perfect_matches(:,3) = x2(:);
perfect_matches(:,4) = y2(:);




%    noisy_matches(:,1) = x1(:)  + randn(no_matches,1) *noise_multiplier;
%    noisy_matches(:,2) = y1(:)	+ randn(no_matches,1) *noise_multiplier;
%    noisy_matches(:,3) = x2(:)	+ randn(no_matches,1) *noise_multiplier;
%    noisy_matches(:,4) = y2(:)	+ randn(no_matches,1) *noise_multiplier;

noisy_matches(:,1) = x1  + normrnd(0, noise_sigma, no_matches,1);
noisy_matches(:,2) = y1	+  normrnd(0, noise_sigma, no_matches,1);
noisy_matches(:,3) = x2	+  normrnd(0, noise_sigma, no_matches,1);
noisy_matches(:,4) = y2	+  normrnd(0, noise_sigma, no_matches,1);


nx1 = noisy_matches(:,1);
ny1 = noisy_matches(:,2);
nx2 = noisy_matches(:,3);
ny2 = noisy_matches(:,4);



%m2(i)' * F * m1(i)

F = inv(C')  * T * R * inv(C);

%this is the wrong answer for the algebraic residual!!    m1(i)' * F * m2(i)

%note here  m3 = 1, so need to adjust this to check the results...
MM = [1 0 0; 0 1 0; 0 0 1/m3];


F2 = MM * F * MM;
true_F = F2 / norm(F2);

%return also the true calibration matrix, note we set the 3rd coordinate to m3 so
% we need to divide the focal length by this in the camera matrixc
true_C = C;
true_C(3,3) = true_C(3,3) * m3;
true_R = R;
true_TX = T;
true_E = T * R;
true_X = X;

%torr_display_matches(perfect_matches);
% 
% %i think this is the right one
% f_true = [F2(1) F2(2,:) F2(3,:)];
% f_true = f_true/norm(f_true);
% 
% 
% %wrong one
% fff = [F(:,1)' F(:,2)' F(:,3)']
% fff = fff/norm(fff);

%e = errf2(fff,x1,y1,x2,y2, no_matches, m3);