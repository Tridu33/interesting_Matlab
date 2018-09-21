clf;                        %清除图形窗口中的内容
x=linspace(0,2*pi,20);
y=sin(x);
axes('Position',[0.2,0.2,0.2,0.7],'GridLineStyle','-.');
plot(y,x);
grid on
axes('Position',[0.4,0.2,0.5,0.5]);
t=0:pi/100:20*pi;
x=sin(t);
y=cos(t);
z=t.*sin(t).*cos(t);
plot3(x,y,z);
axes('Position',[0.55,0.6,0.25,0.3]);
[x,y]=meshgrid(-8:0.5:8);
z=sin(sqrt(x.^2+y.^2))./sqrt(x.^2+y.^2+eps);
mesh(x,y,z);
