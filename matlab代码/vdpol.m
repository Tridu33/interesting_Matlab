function xdot=vdpol(t,x)
xdot(1)=(1-x(2)^2)*x(1)-x(2);
xdot(2)=x(1);
xdot=xdot';
