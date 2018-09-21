function xdot=lorenz(t,x)
xdot=[-8/3,0,x(2);0,-10,10;-x(2),28,-1]*x;
