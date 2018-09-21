j=sqrt(-1);
x=2;y=0.4;
bluecircle=cos(-pi:pi/20:pi)+j*sin(-pi:pi/20:pi)+(j*y-x);
blackcircle=cos(-pi:pi/20:pi)+j*sin(-pi:pi/20:pi)+(j*y);
redcircle=cos(-pi:pi/20:pi)+j*sin(-pi:pi/20:pi)+(j*y+x);
yellowcircle=cos(-pi:pi/20:pi)+j*sin(-pi:pi/20:pi)+(-j*y-x/2);
greencircle=cos(-pi:pi/20:pi)+j*sin(-pi:pi/20:pi)+(-j*y+x/2);
plot(bluecircle,'LineWidth','5');
hold on;
plot(blackcircle,'k','LineWidth','5');
hold on;
plot(redcircle,'r','LineWidth','5');
hold on;
plot(yellowcircle,'y','LineWidth','5');
hold on;
plot(greencircle,'g','LineWidth','5');
x = 0:.01:5;
y=2*exp(-0.5*x).*sin(2*pi*x);
f1 = 2*exp(-0.5*x);
f2 = -2*exp(-0.5*x);
plot(x,y,x,f1,':r',x,f2,':r')

