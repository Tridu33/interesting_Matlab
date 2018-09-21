for j=0:10
axis([-1 1 -1 1]);%设置x,y的坐标范围
axis('off');%覆盖坐标刻度

x1=[0 0 0.8 0.8];
y1=[-0.6 -0.8 -0.8 -0.6];%对水槽中的水进行初设置

line([0;0],[0.2;-0.8],'color','k','linewidth',3);%水槽左壁的颜色和宽度
line([0;0.8],[-0.8;-0.8],'color','k','linewidth',3);%水槽底部的颜色和宽度
line([0.8;0.8],[-0.7;-0.8],'color','k','linewidth',3);%水槽右边出水口的下面的颜色和宽度
line([0.8;0.8],[0.2;-0.6],'color','k','linewidth',3);%水槽右边出水口的上面的颜色和宽度
line([0.8;0.85],[-0.7;-0.7],'color','k','linewidth',3);%出水口的下壁的颜色和宽度
line([0.8;0.85],[-0.6;-0.6],'color','k','linewidth',3);%出水口的上壁的颜色和宽度
line(-0.35,0,'Color','r','linestyle','.', 'markersize',20);%给水线处小圆的颜色和尺寸
line(-0.35,-0.6,'Color','r','linestyle','.', 'markersize',20);%警戒线出小圆的颜色和尺寸
line([-0.45;-0.35],[0;0],'color','k','linewidth',2);%给水线处线条的颜色和宽度
line([-0.45;-0.35],[-0.6;-0.6],'color','k','linewidth',2);%警戒线处线条的颜色和宽度
line([-0.5;-0.5],[0.2,-1],'color','b','linewidth',15);%标杆的颜色和宽度
text(-0.8,0,'给水线');%文字标注“给水线”
text(-0.8,-0.6,'警戒线');%文字标注“警戒线”
text(-0.4,0.6,'防汛检测系统');%文字标注“防汛检测系统”
text(0.6,-0.9,'与江河连接');%文字标注“与江河连接”

water=patch(x1,y1,[0 1 1]);%设置水的颜色及运动路径
ball1=line(0.4,-0.6,'EraseMode','xor','Color','b','linestyle','.', 'markersize',100);%设置水槽中小球的颜色、大小和擦除方式
ball2=line(-0.3,-0,'EraseMode','xor','Color','r','linestyle','.', 'markersize',50);%设置标杆处小球的颜色、大小和擦除方式
gan=line([-0.3;0.4],[-0;-0.6],'EraseMode','xor','color','k','linewidth',1);%设置两球之间连线的颜色、大小和擦除方式

for i=1:120
    a=-0.6+0.005*i;%设置系统的运动规律
    y1=[a -0.8 -0.8 a];%设置水的上升运动过程
    yy1=a;%设置水槽中小球的上升运动过程
    yy2=-a-0.6%设置标杆处小球的上升运动过程
    set(water,'ydata',y1);%设置水的上升运动
    set(ball1,'ydata',yy1);%设置水槽中小球的上升运动
    set(ball2,'ydata',yy2);%设置标杆处小球的上升运动
    set(gan,'ydata',[yy2 yy1]);%设置两球之间的杆的运动
    drawnow;
end%水的上升过程
for i=1:120
    a=-0.005*i;%设置系统运动规律
    y1=[a -0.8 -0.8 a];%设置水的下降运动过程
    yy1=a;%设置水槽中小球的下降运动过程
    yy2=-a-0.6%设置标杆处小球的下降运动过程
      set(water,'ydata',y1);%设置水的下降运动
    set(ball1,'ydata',yy1);%设置水槽中小球下降的运动
    set(ball2,'ydata',yy2);%设置标杆处小球的下降运动
    set(gan,'ydata',[yy2 yy1]);%设置两球之间的杆的下降运动
    drawnow;
end%水的下降过程
water=patch(x1,y1,[0 1 1]);%设置水的颜色及运动路径
ball1=line(0.4,-0.6,'EraseMode','xor','Color','b','linestyle','.', 'markersize',100);%设置水槽中小球的颜色、大小和擦除方式
ball2=line(-0.3,-0,'EraseMode','xor','Color','r','linestyle','.', 'markersize',50);%设置标杆处小球的颜色、大小和擦除方式
gan=line([-0.3;0.4],[-0;-0.6],'EraseMode','xor','color','k','linewidth',1);%设置两球之间连线的颜色、大小和擦除方式

end