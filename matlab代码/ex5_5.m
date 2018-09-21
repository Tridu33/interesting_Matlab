x=0:pi/100:2*pi;
y1=0.2*exp(-0.5*x).*cos(4*pi*x);
plot(x,y1)
hold on
y2=2*exp(-0.5*x).*cos(pi*x);
plot(x,y2);
hold off
