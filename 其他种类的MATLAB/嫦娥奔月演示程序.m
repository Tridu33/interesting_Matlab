%open imread,打开imread的代码figure('name','嫦娥一号与月亮、地球关系');%设置标题名字
s1=[0:.01:2*pi];
hold on;axis equal;%建立坐标系
axis off   % 除掉Axes
r1=10;%月亮到地球的平均距离
r2=3;%嫦娥一号到月亮的平均距离
w1=1;%设置月亮公转角速度
w2=12%设置嫦娥一号绕月亮公转角速度
t=0;%初始时刻为０
pausetime=.002;%设置暂停时间
sita1=0;sita2=0;%设置开始它们都在水平线上
set(gcf,'doublebuffer','on') %消除抖动
plot(-20,18,'color','r','marker','.','markersize',40);
text(-17,18,'地球');%对地球进行标识
p1=plot(-20,16,'color','b','marker','.','markersize',20);
text(-17,16,'月亮');%对月亮进行标识
p1=plot(-20,14,'color','w','marker','.','markersize',13);
text(-17,14,'嫦娥一号');%对嫦娥一号进行标识
plot(0,0,'color','r','marker','.','markersize',60);%画地球
plot(r1*cos(s1),r1*sin(s1));%画月亮公转轨道
set(gca,'xlim',[-20 20],'ylim',[-20 20]);
p1=plot(r1*cos(sita1),r1*sin(sita1),'color','b','marker','.','markersize',30);%画月亮初始位置
l1=plot(r1*cos(sita1)+r2*cos(s1),r1*sin(sita1)+r2*sin(s1));%画嫦娥一号绕月亮公转轨道
p2x=r1*cos(sita1)+r2*cos(sita2);p2y=r1*sin(sita1)+r2*sin(sita2);
p2=plot(p2x,p2y,'w','marker','.','markersize',20);%画嫦娥一号的初始位置
orbit=line('xdata',p2x,'ydata',p2y,'color','r');%画嫦娥一号的运动轨迹
while 1
set(p1,'xdata',r1*cos(sita1),'ydata',r1*sin(sita1));%设置月亮的运动过程
set(l1,'xdata',r1*cos(sita1)+r2*cos(s1),'ydata',r1*sin(sita1)+r2*sin(s1));%设置嫦娥一号绕月亮的公转轨道的运动过程
ptempx=r1*cos(sita1)+r2*cos(sita2);ptempy=r1*sin(sita1)+r2*sin(sita2);
set(p2,'xdata',ptempx,'ydata',ptempy);%设置嫦娥一号的运动过程
p2x=[p2x ptempx];p2y=[p2y ptempy];
set(orbit,'xdata',p2x,'ydata',p2y);%设置嫦娥一号运动轨迹的显示过程
sita1=sita1+w1*pausetime;%月亮相对地球转过的角度
sita2=sita2+w2*pausetime;%嫦娥一号相对月亮转过的角度
pause(pausetime);  %暂停一会
drawnow
end