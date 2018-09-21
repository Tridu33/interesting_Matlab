%作者: 060408602

figure('name','泡泡龙');%定义程序名字

axis([0 65 0 55]) ;  %定义坐标系

axis off

set (gcf,'doublebuffer','on');

line([15;15],[10;50.4],'color','k','linewidth',7);

line([14.7;60.3],[50;50],'color','k','linewidth',7);

line([60;60],[10;50.4],'color','k','linewidth',7);%构建泡泡运动范围

line([0;36],[0;0],'color','k','linewidth',2);

line([0;36],[4;4],'color','k','linewidth',2);

line([40;65],[0;0],'color','k','linewidth',2);

line([40;65],[4;4],'color','k','linewidth',2);%描绘待发射泡泡

hold on;

t=0:pi/200:2*pi;

x1=17-2*cos(t);

y1=48-2*sin(t);

c1=fill(x1,y1,'r');

x2=21-2*cos(t);

y2=48-2*sin(t);

c2=fill(x2,y2,'r');

x3=29-2*cos(t);

y3=48-2*sin(t);

c3=fill(x3,y3,'r');

x4=19-2*cos(t);

y4=44.5-2*sin(t);

c4=fill(x4,y4,'r');%描绘所有红色泡泡

x5=25-2*cos(t);

y5=48-2*sin(t);

c5=fill(x5,y5,'b');

x6=23-2*cos(t);

y6=44.5-2*sin(t);

c6=fill(x6,y6,'b');%描绘所有蓝色泡泡

x7=33-2*cos(t);

y7=48-2*sin(t);

c7=fill(x7,y7,'y');

x8=31-2*cos(t);

y8=44.5-2*sin(t);

c8=fill(x8,y8,'y');%描绘所有黄色泡泡

x9=33-2*cos(t);

y9=41-2*sin(t);

c9=fill(x9,y9,'g');

x10=37-2*cos(t);

y10=48-2*sin(t);

c10=fill(x10,y10,'g');

x11=39-2*cos(t);

y11=44.5-2*sin(t);

c11=fill(x11,y11,'g');%描绘所有绿色泡泡

x12=41-2*cos(t);

y12=48-2*sin(t);

c12=fill(x12,y12,'k');

x13=49-2*cos(t);

y13=48-2*sin(t);

c13=fill(x13,y13,'k');%描绘所有黑色泡泡

x14=34-2*cos(t);

y14=2-2*sin(t);

c14=fill(x14,y14,'k');

x15=30-2*cos(t);

y15=2-2*sin(t);

c15=fill(x15,y15,'g');

x16=26-2*cos(t);

y16=2-2*sin(t);

c16=fill(x16,y16,'b');

x17=22-2*cos(t);

y17=2-2*sin(t);

c17=fill(x17,y17,'r');

x18=18-2*cos(t);

y18=2-2*sin(t);

c18=fill(x18,y18,'r');

x19=14-2*cos(t);

y19=2-2*sin(t);

c19=fill(x19,y19,'g');

x20=10-2*cos(t);

y20=2-2*sin(t);

c20=fill(x20,y20,'g');

x21=6-2*cos(t);

y21=2-2*sin(t);

c21=fill(x21,y21,'y');

x22=2-2*cos(t);

y22=2-2*sin(t);

c22=fill(x22,y22,'k');%描绘所有待发射泡泡

pause(1);

t1=text(31,29,'Ready ?','fontsize',16,'color','k');

pause(1.5);

delete(t1);

t1=text(32,29,'GO ! ! !','fontsize',16,'color','k');

pause(1);

delete(t1);

for i=0:50;%设置运动速度

    xa=x14+0.08*i;

    set(c14,'xdata',xa);

  drawnow;

  end ; %描述第一个黑色泡泡水平运动

%http://lvcha6255.blog.sohu.com/

for i=0:50;%设置运动速度

    xa=x14+4+0.19*i;

    ya=y14+0.85*i;

    set(c14,'xdata',xa,'ydata',ya);

  drawnow;

  end ; %描述第一个黑色泡泡水平和竖直运动

pause(1);

t1=text(28,29,'呵呵，打偏了！','fontsize',16,'color','k');

pause(1);

delete(t1);

for i=0:100;%设置运动速度

    xa=x15+0.08*i;

    set(c15,'xdata',xa);

  drawnow;

  end ; %描述第一个绿色色泡泡水平运动

for i=0:50;%设置运动速度

    ya=y15+0.77*i;

    set(c15,'ydata',ya);

  drawnow;

  end ; %描述第一个绿色泡泡竖直运动

delete(c10,c11,c15);

t1=text(30,29,'Perfect !','fontsize',16,'color','k');

pause(1);

delete(t1);

for i=0:150;%设置运动速度

    xa=x16+0.08*i;

    set(c16,'xdata',xa);

  drawnow;

  end ; %描述蓝色色泡泡水平运动

for i=0:50;%设置运动速度

    xa=x16+12-0.24*i;

    ya=y16+0.80*i;

    set(c16,'xdata',xa,'ydata',ya);

  drawnow;

  end ;%描述蓝色色泡泡水平和竖直运动

  delete(c5,c6,c16);

t1=text(30,29,'Beautiful !','fontsize',16,'color','k');

pause(1);

delete(t1);

for i=0:160;%设置运动速度

    xa=x17+0.1*i;

    set(c17,'xdata',xa);

  drawnow;

  end ; %描述第一个红色色泡泡水平运动

for i=0:50;%设置运动速度

    xa=x17+16-0.22*i;

    ya=y17+0.85*i;

    set(c17,'xdata',xa,'ydata',ya);

  drawnow;

  end ;%描述第一个红色色泡泡水平和竖直运动

t1=text(30,29,'Good !','fontsize',16,'color','k');

pause(1);

delete(t1);

for i=0:200;%设置运动速度

    xa=x18+0.1*i;

    set(c18,'xdata',xa);

  drawnow;

  end ; %描述第二个红色色泡泡水平运动

for i=0:50;%设置运动速度

    xa=x18+20-0.3*i;

    ya=y18+0.85*i;

    set(c18,'xdata',xa,'ydata',ya);

  drawnow;

  end ;%描述第二个红色色泡泡水平和竖直运动

  delete(c1,c2,c3,c4,c17,c18);

t1=text(30,29,'Fantastic !','fontsize',16,'color','k');

pause(1);

delete(t1);

for i=0:240;%设置运动速度

    xa=x19+0.1*i;

    set(c19,'xdata',xa);

  drawnow;

  end ; %描述第二个绿色泡泡水平运动

for i=0:50;%设置运动速度

    xa=x19+24-0.12*i;

    ya=y19+0.7*i;

    set(c19,'xdata',xa,'ydata',ya);

  drawnow;

  end ;%描述第二个绿色色泡泡水平和竖直运动

t1=text(30,29,'Good !','fontsize',16,'color','k');

pause(1);

delete(t1);

for i=0:280;%设置运动速度

    xa=x20+0.1*i;

    set(c20,'xdata',xa);

  drawnow;

  end ; %描述第三个绿色泡泡水平运动

for i=0:50;%设置运动速度

    xa=x20+28-0.12*i;

    ya=y20+0.62*i;

    set(c20,'xdata',xa,'ydata',ya);

  drawnow;

  end ;%描述第三个绿色色泡泡水平和竖直运动

  delete(c20,c19,c9);

t1=text(30,29,'Wonderful !','fontsize',16,'color','k');

pause(1);

delete(t1);

for i=0:200;%设置运动速度

    xa=x21+0.16*i;

    set(c21,'xdata',xa);

  drawnow;

  end ; %描述第一个黄色泡泡水平运动

  for i=0:50;%设置运动速度

    xa=x21+32-0.12*i;

    ya=y21+0.77*i;

    set(c21,'xdata',xa,'ydata',ya);

  drawnow;

  end ;%描述第一个黄色泡泡水平竖直运动

  delete(c21,c7,c8);

  t1=text(30,29,'Terrific !','fontsize',16,'color','k');

pause(1);

delete(t1);

  for i=0:300;%设置运动速度

    xa=x22+0.12*i;

    set(c22,'xdata',xa);

  drawnow;

  end ; %描述第二个黑色泡泡水平运动

  for i=0:50;%设置运动速度

    xa=x22+36+0.12*i;

    ya=y22+0.88*i;

    set(c22,'xdata',xa,'ydata',ya);

  drawnow;

  end ;

  delete(c12,c13,c14,c22);
  t1=text(28,29,'Congratulations !','fontsize',16,'color','k');
  
  %谢谢 可是为什么我每次运行都提示错误[color=Red]：??? Undefined function or method
  %'videowriter' for input arguments of type 'char'版本比较老吧，不支持
%可以这样：
clear,clc
close all
h = figure('numbertitle','off','name','擦除动画演示(挂摆横梁)——Matlabsky');
%绘制横梁
plot([-0.2;0.2],[0;0],'-k','linewidth',20);
%画初始位置的单摆
g = 0.98;%重力加速度,可以调节摆的摆速
l = 1;%摆长
theta0 = pi/4;%初始角度
x = l*sin(theta0);%初始x坐标
y = -l*cos(theta0);%初始y坐标
axis([-0.75,0.75,-1.25,0]);
axis off
%创建摆锤
%擦除模式为xor
head = line(x,y,'color','r','Marker','.','erasemode','xor','markersize',40);
%创建摆杆
body = line([0;x],[-0.05;y],'color','b','linestyle','-','erasemode','xor');
%摆的运动
t = 0;%时间变量
dt = 1/30;%时间增量
i = 0;
while t<=2*pi*sqrt(l/g)
    t = t + dt;
    i = i + 1;
    theta = theta0*cos(sqrt(g/l)*t);%单摆角度与时间的关系
    x= l*sin(theta);
    y=-l*cos(theta);
    if ~ishandle(h),return,end
    set(head,'xdata',x,'ydata',y);%改变擦除对象的坐标数据
    set(body,'xdata',[0;x],'ydata',[-0.05;y]);
    mov(i) = getframe;
end
movie2avi(mov, '单摆.avi', 'compression', 'None','fps',30);
