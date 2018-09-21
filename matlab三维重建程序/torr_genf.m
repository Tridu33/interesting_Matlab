%	By Philip Torr 2002
%	copyright Microsoft Corp.
%generates a set of point matches + their F matrix!@

%we need to make sure that the object isnt too affine

%default values

foc = 256.0;
no_matches = 100;
noise_multiplier = 1;
translation_mult = foc * 2;
translation_adder = 0;

%max number of degrees to rotate
rotation_multplier = 2;
min_Z = 1;
Z_RAN = 10;


m3 = 256.0;
C = eye(3);
C(1,3) = 0;
C(2,3) = 0;
C(3,3) = 1/foc;

R = eye(3);
t = rand(3,1);
t = t * (translation_mult *norm(t)) +translation_adder;
T = [0 -t(3) t(2); t(3) 0 -t(1); -t(2) t(1) 0];
T = T/norm(T);

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
u1 = rand(no_matches,1);
v1 = rand(no_matches,1);
X = rand(3,no_matches);

%noisy data:----
nx1 = rand(no_matches,1);
nx2 = rand(no_matches,1);
ny1 = rand(no_matches,1);
ny2 = rand(no_matches,1);
nu1 = rand(no_matches,1);
nv1 = rand(no_matches,1);

for(i = 1:no_matches)
   X(3,i) = min_Z * foc + Z_RAN * foc * X(3,i);
   X(1,i) = (X(1,i) * 512 -256 ) *X(3,i)/foc;
   X(2,i) = (X(2,i) * 512 -256 ) * X(3,i)/foc ;
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
   
   u1(:) = x2(:) - x1(:);
   v1(:) = y2(:) - y1(:);
   
    

   noisy_matches(:,1) = x1(:)  + randn(no_matches,1) *noise_multiplier;
   noisy_matches(:,2) = y1(:)	+ randn(no_matches,1) *noise_multiplier;
   noisy_matches(:,3) = x2(:)	+ randn(no_matches,1) *noise_multiplier;
   noisy_matches(:,4) = y2(:)	+ randn(no_matches,1) *noise_multiplier;
   
   nx1 = noisy_matches(:,1);
   ny1 = noisy_matches(:,2);
   nx2 = noisy_matches(:,3);
   ny2 = noisy_matches(:,4);
   nu1 = nx2(:) - nx1(:);
   nv1 = ny2(:) - ny1(:);
   
   
   %m2(i)' * F * m1(i)

F = inv(C')  * T * R * inv(C);
   
%this is the wrong answer for the algebraic residual!!    m1(i)' * F * m2(i)

%note here  m3 = 1, so need to adjust this to check the results...
MM = [1 0 0; 0 1 0; 0 0 1/m3];
MMC = MM * inv(C);

%F2 = MM * F * MM;
F2 = MMC * T * R * MMC;
true_F = F2 / norm(F2);
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

tf = true_F;
%tf = F;
0.5 * (trace(tf * tf'))^2 - trace((tf * tf')^2)

tf * (tf' * tf) - 0.5 .* (trace(tf * tf') * tf)

svd(true_F)
eig(true_F)