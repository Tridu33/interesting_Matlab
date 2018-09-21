hf=figure('name','打气筒吹气球');
set(hf,'color','g');

axis([-10,10,-4,4]);
hold on
axis off;   %除掉坐标

xa0=-2.5;%活塞左顶点坐标
xa1=-1.8;%活塞右顶点坐标
xb0=-2;%连杆左顶点坐标
xb1=5;%连杆右顶点坐标

x3=5.6;%转轮坐标
y3=0;%转轮坐标
x4=xb1;%设置连杆头的初始位置横坐标
y4=0;%设置连杆头的初始位置纵坐标
x5=xa1;
y5=0;
x6=x3;%设置连轴初始横坐标
y6=0;%设置连轴初始纵坐标
a=0.7;
b=0.7
c=0.7
a1=line([xa0;xa1],[0;0],'color','m','linestyle','-','linewidth',20);   %设置活塞
a8=line([-2.7;2.3],[0.3;0.3],'color','b','linestyle','-','linewidth',5);%设置打气筒
a9=line([-2.6;2.3],[-0.3;-0.3],'color','b','linestyle','-','linewidth',5);%设置打气筒
a10=line([-2.6;-2.6],[-0.1;-0.37],'color','b','linestyle','-','linewidth',5);%设置打气筒
a11=line([2.0;2.0],[0.1;0.37],'color','b','linewidth',5);%设置打气筒
a12=line([2.0;2.0],[-0.1;-0.37],'color','b','linewidth',5);%设置打气筒
a13=line([-2.6;-2.6],[0.1;0.37],'color','b','linestyle','-','linewidth',5);%设置打气筒
a14=line([-2.7;-2.7],[0.1;-0.1],'color','b','linestyle','-','linewidth',9);%设置气筒嘴
a16=line([-3.2;-3.2],[0.1;-0.1],'color','r','linestyle','-','linewidth',25);%设置气筒嘴
a2=line([xb0;xb1],[0;0],'color','m','linewidth',5);%设置连杆
a5=line(x5,y5,'color','black','linestyle','.','markersize',25);%设置连杆活塞连接头
a4=line(x4,y4,'color','black','linestyle','.','markersize',25);%设置连杆连接头
a6=line([xb1;x3],[0;0],'color','b','linestyle','-','linewidth',7);%设置连杆连接轴
a7=line(x3,0,'color','m','linestyle','.','markersize',50);%设置运动中心
a3=line(x3,y3,'color' ,[0.5 0.6 0.3],'linestyle','.','markersize',85);%设置手轮
len1=6.8;%连杆长
len2=0.7;%活塞长   
r=1.3;%运动半径
dd=0.01;
d=-4;
plot(d,0,'color','r','marker','.','markersize',10);
pausetime=.0001
s=0;
ds=1;
t=0;
dt=0.015*pi;
   while t<=15.68
             t=t+dt;
          drawnow;
    lena1=sqrt((len1)^2-(r*sin(2*t))^2);%连杆在运动过程中横轴上的有效长度
    rr1=r*cos(t);%半径在运动过程中横轴上的有效长度
    xaa1=x3-sqrt(len1^2-(sin(2*t)*r)^2)-(r*cos(2*t));%活塞在运动过程中的右顶点坐标位置
    xaa0=xaa1-2;%%活塞在运动过程中的左顶点坐标位置
    x55=x3-cos(2*t)*r;%连杆在运动过程中横坐标位置
    y55=y3-sin(2*t)*r*0.32;%连杆在运动过程中纵坐标位置
    set(a4,'xdata',x55,'ydata',y55);%设置连杆顶点运动
    set(a1,'xdata',[xaa1-0.2;xaa1],'ydata',[0;0]);%设置活塞运动
    set(a2,'xdata',[xaa1;x55],'ydata',[0;y55]);
    set(a5,'xdata',xaa1);%设置活塞与连杆连接头的运动
    set(a6,'xdata',[x55;x3],'ydata',[y55;0]);
       if (sign(y55-y3)>0)
         s=s+ds;
         d=d-dd;
         if s>200
         s=0;
         d=0;
      end
        set(gcf,'doublebuffer','on');%消除震动  
        plot(d,0,'color','r','marker','.','markersize',s);%画气球
        set(gcf,'doublebuffer','on') %消除抖动   
     pause(pausetime);  %暂停一会
     drawnow;
       end
   end
  x=[-8.0 -7.0 -6.0 -5.5 -4.5 -3.5 -3.7 -3  -4 -5.5 -6.5 -7.5 -9.1 -7.3 ];
  y=[-1.8 -1.2 -2.8 -1.5 -2.8 -0.5 -0.7 0.7 0.2 1.5 0.8  1.2 1.9  0.5];
     fill(x,y,'r');   
     text(-6,0,'pa','fontsize',22);