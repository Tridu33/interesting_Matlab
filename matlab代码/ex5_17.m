[x,y]=meshgrid(0:0.25:4*pi);
z=sin(x+sin(y))-x/10;
mesh(x,y,z);
axis([0 4*pi 0 4*pi -2.5 1]);
