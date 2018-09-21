figure('name','基本电路的模拟');
axis([-3,12,0,10]);%建立坐标系
hold on  %保持当前图形的所有特性
axis('off'); %关闭所有轴标注和控制
%下面是画电池的过程
fill([-1.5,-1.5,1.5,1.5],[1,5,5,1],[0.5,1,1]);%确定坐标轴范围并填充
fill([-0.5,-0.5,0.5,0.5],[5,5.5,5.5,5],[0,0,0]); %确定坐标轴范围并填充
text(-0.5,1.5,'负极');%在坐标上标注说明文字
text(-0.5,3,'电池'); %在坐标上标注说明文字
text(-0.5,4.5,'正极'); %在坐标上标注说明文字
    %下面是画导电线路的过程
plot([0;0],[5.5;6.7],'color','r','linestyle','-','linewidth',4);%绘制二维图形线竖实心红色
plot([0;4],[6.7;6.7],'color','r','linestyle','-','linewidth',4); %绘制二维图形线  实心红色为导线
a=line([4;5],[6.7;7.7],'color','b','linestyle','-','linewidth',4,'erasemode','xor');%画开关蓝色
plot([5.2;9.2],[6.7;6.7],'color','r','linestyle','-','linewidth',4);%绘制图导线为红色
plot([9.2;9.2],[6.7;3.7],'color','r','linestyle','-','linewidth',4);% 绘制图导线竖线为红线
plot([9.2;9.7],[3.7;3.7],'color','r','linestyle','-','linewidth',4); % 绘制图导线横线为红色
plot([0;0],[1;0],'color','r','linestyle','-','linewidth',4);%如上画红色竖线
plot([0;10],[0;0],'color','r','linestyle','-','linewidth',4);%如上画横线
plot([10;10],[0;3],'color','r','linestyle','-','linewidth',4);%画竖线
%下面是画灯泡的过程
fill([9.8,10.2,9.7,10.3],[3,3,3.3,3.3],[0 0 0]);%确定填充范围
plot([9.7,9.7],[3.3,4.3],'color','b','linestyle','-','linewidth',0.5);%绘制灯泡外形线为蓝色
plot([10.3,10.3],[3.3,4.45],'color','b','linestyle','-','linewidth',0.5); %绘制灯泡外形线为蓝色
%以下为绘圆
x=9.7:pi/50:10.3;%绘圆
plot(x,4.3+0.1*sin(40*pi*(x-9.7)),'color','b','linestyle','-','linewidth',0.5); %绘圆
t=0:pi/60:2*pi; %绘圆
plot(10+0.7*cos(t),4.3+0.6*sin(t),'color','b'); %绘圆
    %下面是箭头及注释的显示
text(4.5,10,'电流运动方向'); %在坐标上标注说明文字
line([4.5;6.6],[9.4;9.4],'color','r','linestyle','-','linewidth',4,'erasemode','xor');%绘制箭头横线
line(6.7,9.4,'color','b','linestyle','>','erasemode','xor','markersize',10);% %绘制箭头三角形
pause(1);
%下面是开关闭合的过程
t=0;
y=7.7;
while y>6.7 %电路总循环控制开关动作条件
    x=4+sqrt(2)*cos(pi/4*(1-t));
    y=6.7+sqrt(2)*sin(pi/4*(1-t));
    set(a,'xdata',[4;x],'ydata',[6.7;y]);
    drawnow;
    t=t+0.1;
end
%下面是开关闭合后模拟大致电流流向的过程
pause(1);
light=line(10,4.3,'color','y','marker','.','markersize',40,'erasemode','xor');%画灯丝发出的光：黄色
%画电流的各部分
h=line([1;1],[5.2;5.6],'color','r','linestyle','-','linewidth',4,'erasemode','xor');
g=line(1,5.7,'color','b','linestyle','^','erasemode','xor','markersize',10);
%给循环初值
t=0;
m2=5.7;
n=5.7;
while n<6.3;%确定电流竖向循环范围
  m=1;
  n=0.05*t+5.7;
  set(h,'xdata',[m;m],'ydata',[n-0.5;n-0.1]);
  set(g,'xdata',m,'ydata',n);
  t=t+0.01;
drawnow;
end
t=0;
while t<2;%在转角处的停顿时间
    m=1.2-0.2*cos((pi/4)*t);
    n=6.3+0.2*sin((pi/4)*t);
   set(h,'xdata',[m-0.5;m-0.1],'ydata',[n;n]);
   set(g,'xdata',m,'ydata',n);
   t=t+0.05;
drawnow;
end
t=0;
while t<0.5 %在转角后的停顿时间
    t=t+0.5;
    g=line(1.2,6.5,'color','b','linestyle','^','markersize',10,'erasemode','xor');%绘制第二个箭头
    g=line(1.2,6.5,'color','b','linestyle','>','markersize',10,'erasemode','xor'); %绘制第二个箭头
    set(g,'xdata',1.2,'ydata',6.5);
drawnow;
end
pause(0.5);
t=0;
while m<8 % 确定第二个箭头的循环范围
    m=1.1+0.05*t;
    n=6.5;
    set(g,'xdata',m+0.1,'ydata',6.5);
    set(h,'xdata',[m-0.4;m],'ydata',[6.5;6.5]);
    t=t+0.05;
drawnow;
end
t=0;
while t<2 %%在转角后的停顿时间
    m=8.1+0.2*cos(pi/2-pi/4*t);
    n=6.3+0.2*sin(pi/2-pi/4*t);
    set(g,'xdata',m,'ydata',n);
    set(h,'xdata',[m;m],'ydata',[n+0.1;n+0.5]);
    t=t+0.05;
drawnow;
end
t=0;
while t<0.5 %在转角后的停顿时间
    t=t+0.5;
%绘制第三个箭头
    g=line(8.3,6.3,'color','b','linestyle','>','markersize',10,'erasemode','xor');
    g=line(8.3,6.3,'color','b','linestyle','v','markersize',10,'erasemode','xor');
    set(g,'xdata',8.3,'ydata',6.3);
drawnow;
end

pause(0.5);
t=0;
while n>1 %确定箭头的运动范围
    m=8.3;
    n=6.3-0.05*t;
    set(g,'xdata',m,'ydata',n);
    set(h,'xdata',[m;m],'ydata',[n+0.1;n+0.5]);
    t=t+0.04;
drawnow;
end
t=0;
while t<2%箭头的起始时间
    m=8.1+0.2*cos(pi/4*t);
    n=1-0.2*sin(pi/4*t);
    set(g,'xdata',m,'ydata',n);
    set(h,'xdata',[m+0.1;m+0.5],'ydata',[n;n]);
    t=t+0.05;
drawnow;
end
t=0;
while t<0.5
    t=t+0.5;
%绘制第四个箭头
    g=line(8.1,0.8,'color','b','linestyle','v','markersize',10,'erasemode','xor');
    g=line(8.1,0.8,'color','b','linestyle','<','markersize',10,'erasemode','xor');
    set(g,'xdata',8.1,'ydata',0.8);
drawnow;
end
pause(0.5);
t=0;
while m>1.2 %箭头的运动范围
    m=8.1-0.05*t;
    n=0.8;
    set(g,'xdata',m,'ydata',n);
    set(h,'xdata',[m+0.1;m+0.5],'ydata',[n;n]);
    t=t+0.04;
drawnow;
end
t=0;
while t<2 %停顿时间
    m=1.2-0.2*sin(pi/4*t);
    n=1+0.2*cos(pi/4*t);
    set(g,'xdata',m,'ydata',n);
    set(h,'xdata',[m;m+0.5],'ydata',[n-0.1;n-0.5]);
    t=t+0.05;
drawnow;
end
t=0;
while t<0.5 %画第五个箭头
    t=t+0.5;
    g=line(1,1,'color','b','linestyle','<','markersize',10,'erasemode','xor');
    g=line(1,1,'color','b','linestyle','^','markersize',10,'erasemode','xor');
    set(g,'xdata',1,'ydata',1);
drawnow;
end
t=0;
while n<6.3  %循环范围
    m=1;
    n=1+0.05*t;
    set(g,'xdata',m,'ydata',n);
    set(h,'xdata',[m;m],'ydata',[n-0.5;n-0.1]);
    t=t+0.04;
drawnow;
end
%下面是开关断开后的情况
t=0;
y=6.7;
while y<7.7 %开关的断开
    x=4+sqrt(2)*cos(pi/4*t);
    y=6.7+sqrt(2)*sin(pi/4*t);
    set(a,'xdata',[4;x],'ydata',[6.7;y]);
    drawnow;
    t=t+0.1;
end
pause(0.5);%开关延时作用
nolight=line(10,4.3,'color','y','marker','.','markersize',40,'erasemode','xor');
end