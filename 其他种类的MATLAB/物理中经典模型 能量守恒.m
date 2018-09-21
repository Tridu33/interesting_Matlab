fill([6,7,7,6],[5,5,0,0],[0,0.5,0]);%右边竖条的填充
hold on; %保持当前图形及轴系的所有特性
fill([2,6,6,2],[3,3,0,0],[0,0.5,0]);%左边竖条的填充
hold on;% 保持当前图形及轴系的所有特性
t1=0:pi/60:pi;
plot(4-2*sin(t1-pi/2),5-2*cos(t1-pi/2));%绘制中间的凹弧图形
grid;%添加网格线
axis([0,9,0,9]);%定义坐标轴的比例

%axis('off');%关闭所有轴标注，标记，背景
fill([1,2,2,1],[5,5,0,0],[0,0.5,0]);%中间长方形的填充
hold on;% 保持当前图形及轴系的所有特性
title('31608118');%定义图题
x0=6;
y0=5;
head1=line(x0,y0,'color','r','linestyle','.','erasemode','xor','markersize',30);

head2=line(x0,y0,'color','r','linestyle','.','erasemode','xor','markersize',50); %设置小球颜色,大小,线条的擦拭方式

t=0;%设置小球的初始值
dt=0.001;%设置运动周期
t1=0;%设置大球的初始值
dt1=0.001;
while 1%条件表达式
     t=t+dt;
     x1=9-1*t;
     y1=5;
   
      x3=6;
     y3=5;
     if t>0
           x2=6;
     y2=5;%设置小球的运动轨迹
end
    if t>2.8
    t=t+dt;
         a=sin(t-3);

       x1=6.1;
     y1=5.1;
    x3=4-2*sin(1.5*a);
   y3=5-2*cos(1.5*a);%设置大球的运动轨迹
end
        set(head1,'xdata',x1,'ydata',y1);%设置球的运动
         set(head2,'xdata',x3,'ydata',y3);
   
    drawnow;
end