hf=figure('name','曲柄滑块机构');
set(hf,'color','g');
hold on
axis([-6,6,-4,4]);
grid  on
axis('off');
xa0=-5;%活塞左顶点坐标
xa1=-2.5;%活塞右顶点坐标
xb0=-2.5;%连杆左顶点坐标
xb1=2.2;%连杆右顶点坐标

x3=3.5;%转轮坐标
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

a1=line([xa0;xa1],[0;0],'color','b','linestyle','-','linewidth',40);   %设置活塞
a3=line(x3,y3,'color',[0.5 0.6 0.3],'linestyle','.','markersize',300);%设置转轮
a2=line([xb0;xb1],[0;0],'color','black','linewidth',10);%设置连杆
a5=line(x5,y5,'color','black','linestyle','.','markersize',40);%设置连杆活塞连接头
a4=line(x4,y4,'color','black','linestyle','.','markersize',50);%设置连杆连接头
a6=line([xb1;x3],[0;0],'color','black','linestyle','-','linewidth',10);
a7=line(x3,0,'color','black','linestyle','.','markersize',50);%设置运动中心
a8=line([-5.1;-0.2],[0.7;0.7],'color','y','linestyle','-','linewidth',5);%设置汽缸壁
a9=line([-5.1;-0.2],[-0.72;-0.72],'color','y','linestyle','-','linewidth',5);%设置汽缸壁
a10=line([-5.1;-5.1],[-0.8;0.75],'color','y','linestyle','-','linewidth',5);%设置汽缸壁
a11=fill([-5,-5,-5,-5],[0.61,0.61,-0.61,-0.61],[a,b,c]);%设置汽缸气体

len1=4.8;%连杆长
len2=2.5;%活塞长
r=1.3;%运动半径
dt=0.015*pi;
t=0;

while 1
    t=t+dt;
if t>2*pi
    t=0;
end
    lena1=sqrt((len1)^2-(r*sin(t))^2);%连杆在运动过程中横轴上的有效长度
    rr1=r*cos(t);%半径在运动过程中横轴上的有效长度
    xaa1=x3-sqrt(len1^2-(sin(t)*r)^2)-(r*cos(t));%活塞在运动过程中的右顶点坐标位置
    xaa0=xaa1-2.5;%%活塞在运动过程中的左顶点坐标位置
    x55=x3-cos(t)*r;%连杆在运动过程中横坐标位置
    y55=y3-sin(t)*r;%连杆在运动过程中纵坐标位置
    set(a4,'xdata',x55,'ydata',y55);%设置连杆顶点运动
    set(a1,'xdata',[xaa1-2.5;xaa1],'ydata',[0;0]);%设置活塞运动
    set(a2,'xdata',[xaa1;x55],'ydata',[0;y55]);
    set(a5,'xdata',xaa1);%设置活塞与连杆连接头的运动
    set(a6,'xdata',[x55;x3],'ydata',[y55;0]);
    set(a11,'xdata',[-5,xaa0,xaa0,-5]);%设置气体的填充
    set(gcf,'doublebuffer','on');%消除震动
    drawnow;
end