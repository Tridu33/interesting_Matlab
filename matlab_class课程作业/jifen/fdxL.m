function [dx]=fdxL(t,x)
z=0.03;L=1;g=9.8;
w=sqrt(g/L);
dth=x(1);
th=x(2);
dx=[-2*z*w*dth-w^2*th;dth];
