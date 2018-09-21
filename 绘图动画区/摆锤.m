h=figure('numbertitle','off','name','擦除动画演示(挂摆横梁)——Matlabsky')
%绘制横梁
plot([-0.2;0.2],[0;0],'-k','linewidth',20);
%画初始位置的单摆
g=0.98;%重力加速度,可以调节摆的摆速
l=1;%摆长
theta0=pi/4;%初始角度
x0=l*sin(theta0);%初始x坐标
y0=-l*cos(theta0);%初始y坐标
axis([-0.75,0.75,-1.25,0]);
axis off
%创建摆锤
%擦除模式为xor
head=line(x0,y0,'color','r','linestyle','.','erasemode','xor','markersize',40);
%创建摆杆
body=line([0;x0],[-0.05;y0],'color','b','linestyle','-','erasemode','xor');
%摆的运动
t=0;%时间变量
dt=0.01;%时间增量
while 1
t=t+dt;
theta=theta0*cos(sqrt(g/l)*t);%单摆角度与时间的关系
x=l*sin(theta);
y=-l*cos(theta);
if ~ishandle(h),return,end
set(head,'xdata',x,'ydata',y);%改变擦除对象的坐标数据
set(body,'xdata',[0;x],'ydata',[-0.05;y]);
drawnow;%刷新屏幕
end