clear;   %清除工作区
clc;     %清除命令区
figure('name','武工院打桩机');   %设置标题
axis ([0 ,10,0,10]);   %建立坐标系
hold on;
axis off;   %除掉坐标
text(3,9.8,'武工院打桩机','fontsize',20,'color','r');
%画打桩机支架
c1=line([1;5.5],[ 0.15;0.15],'color','k','linewidth',8);
c2=line([1.7;5.2],[ 1.5;0.15],'color','k','linewidth',4);
c3=line([1.8;5.2],[ 0.1;8],'color','k','linewidth',4);
c4=line([1.7;5.2],[ 1.5;8],'color','k','linewidth',2);
c5=line([1.2;1.8],[ 0.5;0.5],'color','k','linewidth',13);
fill([4.9,5.3,5.3,4.9],[8.0,8.0,0.3,0.3],[1,0.1,0.5]);
fill([4.4,4.6,5.6,5.8,5.6,4.6],[8.4,8.3,8.3,8.4,8.0,8.0],[1,0.1,0.5])
%画打桩机运动部分和水泥桩
b1=line([8;8],[1;6],'color','b','linewidth',6);
b2=line([5.5,5.5],[7.9,8],'color','k','linewidth',1);
b3=line([5.3,5.55],[7.9,7.9],'color','k','linewidth',3);
b4=line([5.5,5.5],[7.9,6.3],'color','k','linewidth',3);
b5=line([5.5,5.5],[7,6.6],'color','k','linewidth',10);
b6=line([5.5,5.5],[6.6,6.3],'color','k','linewidth',12);
pausetime=1.6;   %设置暂停时间
pause(pausetime);
%吊装水泥桩
s=0;   
ds=0.01;
pausetime1=.002;
while s<2.5    %水泥桩向左移动
      s=s+ds;
      set(b1,'xdata',[8-s;8-s],'ydata',[1;6]);
      pause(pausetime1);
end
pausetime2=1;
pause(pausetime2);
s=0;   
ds=0.01;
while s<1     %水泥桩向下移动
     s=s+ds;
     set(b1,'xdata',[5.5;5.5],'ydata',[1-s;6-s]);
     pause(pausetime1);
end
pause(pausetime2);
s=0;   
ds=0.01;
while s<1.3    %打桩机运动部分下移与水泥桩顶端相接触
      s=s+ds;
      set(b2,'xdata',[5.5;5.5],'ydata',[7.9-s,8]);
      set(b3,'xdata',[5.3;5.55],'ydata',[7.9-s,7.9-s]);
      set(b4,'xdata',[5.5;5.5],'ydata',[7.9-s,6.3-s]);
      set(b5,'xdata',[5.5;5.5],'ydata',[7-s,6.6-s]);
      set(b6,'xdata',[5.5;5.5],'ydata',[6.6-s,6.3-s]);
      pause(pausetime1);
end
%打桩机开始打桩
pausetime3=.4;
pause(pausetime2);
s=0;   
ds=0.06;  %设定打桩进度
while s<4
a=0;   
da=0.01;
pausetime4=.0002;                  
while a<.4   %两个子循环设置打桩机铁锺上下反复运动
     a=a+da;
       set(b5,'xdata',[5.5;5.5],'ydata',[5.7-s+a,5.3-s+a]);
     pause(pausetime4);
end
a=0;   
while a<.4
     a=a+da;
       set(b5,'xdata',[5.5;5.5],'ydata',[6.1-s-a,5.7-s-a]);
     pause(pausetime4);
end
s=s+ds;
%打桩机运动部分与水泥桩同时向下移动
set(b1,'xdata',[5.5;5.5],'ydata',[0;5-s]);
set(b2,'xdata',[5.5;5.5],'ydata',[6.6-s,8]);
set(b3,'xdata',[5.3;5.55],'ydata',[6.6-s,6.6-s]);
set(b4,'xdata',[5.5;5.5],'ydata',[6.6-s,5-s]);
set(b5,'xdata',[5.5;5.5],'ydata',[5.7-s,5.3-s]);
set(b6,'xdata',[5.5;5.5],'ydata',[5.3-s,5-s]);
pause(pausetime3);
end