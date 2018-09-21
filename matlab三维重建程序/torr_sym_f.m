%	By Philip Torr 2002
%	copyright Microsoft Corp.
%%%%%%this is going to be my first try at some symbolic stuff

%%%the purpose of this file is to set up an essential matrix that you can later do symbolic manipulation of,.


syms tx ty tz;

Tx = [0 -tz ty; tz 0 -tx; -ty tx 0];

%rodriggues formula a rotation angle l m n axis

syms lx ly lz a

Id = [1 0 0; 0 1 0; 0 0 1]
Ax = [0 -lz ly; lz 0 -lx; -ly lx 0];
rot_axT = [ lx ly lz]
rot_ax = [ lx; ly; lz]

R = (cos(a) * Id + sin(a) * Ax + (1 - cos(a)) *  rot_ax * rot_axT)


E = Tx * R

syms foc

Ca = [1 0 0; 0 1 0; 0 0 foc]

G = Ca * E * Ca
%det(E)
%0.5 * (trace( E * E'))^2 - trace((E * E')^2)

syms x1 x2 y1 y2



r = [x2 y2 1] * G * [x1; y1; 1]