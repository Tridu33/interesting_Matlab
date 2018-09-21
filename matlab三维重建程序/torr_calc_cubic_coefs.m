% Many thanks to Kurt Ditzel
% Acuity Research for this bug fix...


function p = calc_cubic_coefs(f1, f2)
%
% use symbolic solver
% 

c11 = f1(1);
c12 = f1(2);
c13 = f1(3);
c21 = f1(4);
c22 = f1(5);
c23 = f1(6);
c31 = f1(7);
c32 = f1(8);
c33 = f1(9);

d11 = f2(1);
d12 = f2(2);
d13 = f2(3);
d21 = f2(4);
d22 = f2(5);
d23 = f2(6);
d31 = f2(7);
d32 = f2(8);
d33 = f2(9);

%syms c11 c12 c13 c21 c22 c23 c31 c32 c33;
%syms d11 d12 d13 d21 d22 d23 d31 d32 d33;
%syms f1 f2 a X Y D T;

%f1 = [c11, c12, c13, c21, c22, c23, c31, c32, c33];
%f2 = [d11, d12, d13, d21, d22, d23, d31, d32, d33];
% 
% disp('X')
% X = a*f1 + (1-a)*f2;
% pretty(X)
% disp('Y');
% Y = reshape(X,3,3).';
% pretty(Y)
% D = det(Y);
% disp('D');
% %pretty(D);
% 
% disp('Collected coeffs of a')
% T = collect(simplify(D),a)

% solve for  given the points
%
% p = 
p = [(d11*c22*d33+c21*d13*d32-c21*d13*c32-c21*c13*d32+c21*c13*c32-c21*d12*d33+c21*d12*c33+c21*c12*d33-c21*c12*c33+c11*c22*c33-c11*c22*d33+d11*c23*c32-d11*c23*d32-d11*d23*c32-d11*c22*c33-c11*d22*c33-c11*c23*c32+d11*d22*c33-d21*d13*d32+c11*c23*d32+c11*d22*d33+d21*d12*d33-d31*d13*c22-d31*c13*d22+d31*c13*c22+d31*d12*c23+d31*c12*d23-d31*c12*c23-c31*d13*d22+c31*d13*c22+c31*c13*d22-c31*c13*c22+c31*d12*d23-c31*d12*c23-c31*c12*d23+c31*c12*c23+d21*d13*c32+d21*c13*d32-d21*c13*c32-d21*d12*c33-d21*c12*d33+d21*c12*c33+d31*d13*d22-d31*d12*d23+c11*d23*c32-d11*d22*d33+d11*d23*d32-c11*d23*d32),
+(-2*d11*c22*d33-2*c21*d13*d32+c21*d13*c32+c21*c13*d32+2*c21*d12*d33-c21*d12*c33-c21*c12*d33+c11*c22*d33-d11*c23*c32+2*d11*c23*d32+2*d11*d23*c32+d11*c22*c33+c11*d22*c33-2*d11*d22*c33+3*d21*d13*d32-c11*c23*d32-2*c11*d22*d33-3*d21*d12*d33+2*d31*d13*c22+2*d31*c13*d22-d31*c13*c22-2*d31*d12*c23-2*d31*c12*d23+d31*c12*c23+2*c31*d13*d22-c31*d13*c22-c31*c13*d22-2*c31*d12*d23+c31*d12*c23+c31*c12*d23-2*d21*d13*c32-2*d21*c13*d32+d21*c13*c32+2*d21*d12*c33+2*d21*c12*d33-d21*c12*c33-3*d31*d13*d22+3*d31*d12*d23-c11*d23*c32+3*d11*d22*d33-3*d11*d23*d32+2*c11*d23*d32),
+(-3*d21*d13*d32-c11*d23*d32+3*d11*d23*d32-c21*d12*d33-c31*d13*d22+d11*c22*d33+d21*d13*c32+c21*d13*d32-d11*d23*c32+3*d21*d12*d33+c11*d22*d33+d11*d22*c33-d21*c12*d33+d21*c13*d32-3*d11*d22*d33-d11*c23*d32-d31*c13*d22+d31*c12*d23+3*d31*d13*d22-d31*d13*c22+c31*d12*d23-3*d31*d12*d23-d21*d12*c33+d31*d12*c23),
-d21*d12*d33+d11*d22*d33-d11*d23*d32+d21*d13*d32-d31*d13*d22+d31*d12*d23];
