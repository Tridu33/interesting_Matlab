axis([-1.6,12.6,-1.6,10.7])%确定坐标轴参数范围
hold on %保持当前图形及轴系的所有特性
fill([-2,13,13,-2],[-2,-2,11,11],[0,1,0]);%填充底座背景
fill([-1,12,12,-1],[-1,-1,10,10],[0,0.5,0]);%填充底座背景
ball1=line(0,5,'color','r','marker','.','erasemode','xor','markersize',60);%设置小球颜色,大小,线条的擦拭方式
ball2=line(8,9,'color','g','marker','.','erasemode','xor','markersize',60);%设置小球颜色,大小,线条的擦拭方式
ball3=line(-1,-1,'color','g','marker','.','erasemode','xor','markersize',80);%设置左下角圆的颜色,大小,线条的擦拭方式
ball4=line(12,-1,'color','g','marker','.','erasemode','xor','markersize',80);%设置右下角圆的颜色,大小,线条的擦拭方式
ball3=line(-1,10,'color','g','marker','.','erasemode','xor','markersize',80);%设置左上角圆的颜色,大小,线条的擦拭方式
ball4=line(12,10,'color','g','marker','.','erasemode','xor','markersize',80);%设置右上角圆的颜色,大小,线条的擦拭方式
title('完全非弹碰在模拟台球比赛的应用', 'color','r','fontsize',15);%图形标题
pause(1)%设定暂停时间的长度
t=0;dt=0.005;%设制初始数值
while t<7.2%设定横轴范围
    t=t+dt;%设制横轴计算公式
    y=1/2*t+5;%设制纵轴计算公式
     set(ball1,'xdata',t,'ydata',y)%设制球的运动
  drawnow;%刷新屏幕
end  %结束
while t<8.8%设定横轴范围
    t=t+dt;%设制横轴计算公式
    y=1/2*t+5;%设制纵轴计算公式
     set(ball2,'xdata',t,'ydata',y)%设制球的运动
  drawnow;%刷新屏幕
end  %结束
while t<11.5%设定横轴范围
    t=t+dt;%设制横轴计算公式
    y=-1/2*t+14.3;%设制纵轴计算公式
     set(ball2,'xdata',t,'ydata',y)%设制球的运动
  drawnow;%刷新屏幕
end%结束
while t>-0.5%设制横轴范围
    t=t-dt;%设制横轴计算公式
    y=1/2*t+2.90;%设制纵轴计算公式
     set(ball2,'xdata',t,'ydata',y)%设制球的运动
  drawnow;%刷新屏幕
end%结束
while t<6%设制横轴范围
    t=t+dt;%设制横轴计算公式
    y=-1/2*t+2.40;%设制纵轴计算公式
     set(ball2,'xdata',t,'ydata',y)%设制球的运动
  drawnow;%刷新屏幕
end%结束
while t<11.5%设制横轴范围
    t=t+dt;%设制横轴计算公式
    y=1/2*t-3.0;%设制纵轴计算公式
     set(ball2,'xdata',t,'ydata',y)%设制球的运动
  drawnow;%刷新屏幕
end%结束
while t>-2%设制横轴范围
    t=t-dt;%设制横轴计算公式
    y=-t*7.65/12.9+9.57;%设制纵轴计算公式
     set(ball2,'xdata',t,'ydata',y)%设制球的运动
  drawnow;%刷新屏幕
end%结束
text(2,5,'好！进球了啊！！！恭喜！','fontsize',16,'color','r'); %显示字幕的颜色和大小