t=0:pi/100:20*pi;
x=sin(t);
y=cos(t);
z=t.*sin(t).*cos(t);
plot3(x,y,z);
title('Line in 3-D Space');
xlabel('X');ylabel('Y');zlabel('Z');
grid on;
