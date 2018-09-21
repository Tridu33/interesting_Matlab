figure('name','自控门');
axis ([0 ,60,0,60]);
hold on;
axis off;
text(23,55,'自控门','fontsize',20,'color','r');
text(7,32,'放大器','fontsize',8,'color','k');
text(18,40,'伺服电动机','fontsize',8,'color','r');
text(18,14,'门','fontsize',10,'color','r');
text(43.5,23,'开门开关','fontsize',10,'color','k');
text(43.5,8,'关门开关','fontsize',10,'color','k');
%画导线
c1=line([1;55],[50;50],'color','g','linewidth',2);   
c2=line([4;35],[45;45],'color','g','linewidth',2);
c3=line([4;7],[35;35],'color','g','linewidth',2);
c4=line([1;1],[30;50],'color','g','linewidth',2);
c5=line([4;4],[35;45],'color','g','linewidth',2);
c6=line([1;7],[30;30],'color','g','linewidth',2);
c7=line([55;55],[15;50],'color','g','linewidth',2);
c8=line([49;55],[15;15],'color','g','linewidth',2);
%画放大器
c9=line([7;7],[28;37],'color','g','linewidth',2);
c10=line([7;12],[37;37],'color','g','linewidth',2);
c11=line([12;12],[28;37],'color','g','linewidth',2);
c12=line([7;12],[28;28],'color','g','linewidth',2);
hold on;
%画箭头
j1=line([6;7],[35.5;35],'linewidth',2);
j2=line([6;7],[34.5;35],'linewidth',2);
j3=line([6;7],[30.5;30],'linewidth',2);
j4=line([6;7],[29.5;30],'linewidth',2);
j5=line([43;44],[20;20.5],'linewidth',2);
j6=line([43;44],[20;19.5],'linewidth',2);
j7=line([43;44],[10;10.5],'linewidth',2);
j8=line([43;44],[10;9.5],'linewidth',2);
j9=line([36;37],[10.5;10],'linewidth',2);
j10=line([36;37],[9.5;10],'linewidth',2);
hold on;
%画电阻
fill([37,38,38,37],[28,28,2,2],[1,0.1,0.5]);%左电阻
fill([42,43,43,42],[28,28,2,2],[1,0.1,0.5]);%右电阻
%画连接电阻的导线
f1=line([25;37],[10;10],'color','g','linewidth',2);
f2=line([35;35],[10;45],'color','g','linewidth',2);
f3=line([37.5;37.5],[1;2],'color','g','linewidth',2);
f4=line([37.5;42.5],[1;1],'color','g','linewidth',2);
f5=line([42.5;42.5],[1;2],'color','g','linewidth',2);
f6=line([37.5;37.5],[28;29],'color','g','linewidth',2);
f7=line([37.5;42.5],[29;29],'color','g','linewidth',2);
f8=line([42.5;42.5],[28;29],'color','g','linewidth',2);
f9=line([40;40],[17;29],'color','g','linewidth',2);
f10=line([40;40],[1;15.5],'color','g','linewidth',2);
%画电源
f11=line([39;41],[15.5;15.5],'color','r','linewidth',2);%负极
f12=line([38.5;41.5],[17;17],'color','r','linewidth',2);%正极
f13=line([43;48],[20;20],'color','g','linewidth',2); %开门开关
f14=line([43;48],[10;10],'color','g','linewidth',2); %关门开关
g0=line([48;49],[20;15],'color','k','linewidth',2);  %闸刀
door=line([25;25],[5;15],'color','g','linewidth',25);%画门
d1=line([25;25],[27.5;15],'color','g','linewidth',2);%画门顶的绳索
hold on;

%画电机的两端（用两个椭圆）
t=0:pi/100:2*pi;
fill(18+2*sin(t),32.5+5*cos(t),[0.7,0.85,0.9]);%电机左端
fill(25+2*sin(t),32.5+5*cos(t),[0.7,0.85,0.9]);%电机右端
e0=line([12;18],[32.5;32.5],'color','r','linewidth',2);%画连接电机中轴的线
%画电机的表面（用八根不同颜色的线代替，每根之间相差pi/4）
%为简便起见，初始条件下可将八根线分成两组放在电机的顶端和底端
sig1=line([18;25],[37.5;37.5],'color','r','linestyle','-','linewidth',2);
sig2=line([18;25],[27.5;27.5],'color','m','linestyle','-','linewidth',2);
sig3=line([18;25],[37.5;37.5],'color','w','linestyle','-','linewidth',2);
sig4=line([18;25],[27.5;27.5],'color','b','linestyle','-','linewidth',2);
sig5=line([18;25],[37.5;37.5],'color','c','linestyle','-','linewidth',2);
sig6=line([18;25],[27.5;27.5],'color','g','linestyle','-','linewidth',2);
sig7=line([18;25],[37.5;37.5],'color','k','linestyle','-','linewidth',2);
sig8=line([18;25],[27.5;27.5],'color','b','linestyle','-','linewidth',2);


a=0;    %设定电机运转的初始角度
da=0.015;%设定电机正转的条件
s=0;    %设定门运动的初始条件
ds=0.015;%设定门运动的周期
while s<10    %条件表达式  (当0<s<10时，电机正转,门上升)
a=a+da;

    %（当线运动到电机背面时会覆盖电机左端，用abs可解决这一问题，
  xa1=18+abs(2*sin(a));% 增强逼真感）
  xa2=25+2*sin(a);
  ya1=32.5+5*cos(a);
  ya2=32.5+5*cos(a);%设定sig1的两端点坐标（sig1是对应0的线）
  xb1=18+2*abs(sin(a+pi));
  xb2=25+2*sin(a+pi);
  yb1=32.5+5*cos(a+pi);
  yb2=32.5+5*cos(a+pi); %设定sig2的两端点坐标（sig2是对应pi的线）
  xc1=18+abs(2*sin(a+pi/2));
  xc2=25+2*sin(a+pi/2);
  yc1=32.5+5*cos(a+pi/2);
  yc2=32.5+5*cos(a+pi/2);%设定sig3的两端点坐标（sig3是对应pi/2的线）
  xd1=18+2*abs(sin(a-pi/2));
  xd2=25+2*sin(a-pi/2);
  yd1=32.5+5*cos(a-pi/2);
  yd2=32.5+5*cos(a-pi/2);%设定sig4的两端点坐标（sig4是对应-pi/2的线）

  xe1=18+abs(2*sin(a+pi/4));
  xe2=25+2*sin(a+pi/4);
  ye1=32.5+5*cos(a+pi/4);
  ye2=32.5+5*cos(a+pi/4);%设定sig5的两端点坐标（sig5是对应pi/4的线）
  xf1=18+2*abs(sin(a+pi*3/4));
  xf2=25+2*sin(a+pi*3/4);
  yf1=32.5+5*cos(a+pi*3/4);
  yf2=32.5+5*cos(a+pi*3/4);%设定sig6的两端点坐标（sig6是对应pi*3/4的线）
  xg1=18+abs(2*sin(a-pi*3/4));
  xg2=25+2*sin(a-3*pi/4);
  yg1=32.5+5*cos(a-3*pi/4);
  yg2=32.5+5*cos(a-3*pi/4);%设定sig7的两端点坐标（sig7是对应-3*pi/4的线）
  xh1=18+2*abs(sin(a-pi/4));
  xh2=25+2*sin(a-pi/4);
  yh1=32.5+5*cos(a-pi/4);
  yh2=32.5+5*cos(a-pi/4);  %设定sig8的两端点坐标（sig8是对应-pi/4的线）
  %绘制电机表面各线条的运动
  set(sig1,'xdata',[xa1;xa2],'ydata',[ya1;ya2]);
  set(sig2,'xdata',[xb1;xb2],'ydata',[yb1;yb2]);
  set(sig3,'xdata',[xc1;xc2],'ydata',[yc1;yc2]);
  set(sig4,'xdata',[xd1;xd2],'ydata',[yd1;yd2]);
  set(sig5,'xdata',[xe1;xe2],'ydata',[ye1;ye2]);
  set(sig6,'xdata',[xf1;xf2],'ydata',[yf1;yf2]);
  set(sig7,'xdata',[xg1;xg2],'ydata',[yg1;yg2]);
  set(sig8,'xdata',[xh1;xh2],'ydata',[yh1;yh2]);

s=s+ds;
set(door,'xdata',[25;25],'ydata',[5+s;15+s]); %绘制门的向上运动
set(d1,'xdata',[25;25],'ydata',[27.5;15+s]);  %绘制门顶的绳索的向上运动
set(f1,'xdata',[25;37],'ydata',[10+s;10+s]);  %绘制门和电阻之间两根导线的运动
set(f2,'xdata',[35;35],'ydata',[45;10+s]);   
set(j9,'xdata',[36;37],'ydata',[10.5+s;10+s]);%绘制上箭头的向上运动                                            
set(j10,'xdata',[36;37],'ydata',[9.5+s;10+s]);%绘制下箭头的向上运动
set(gcf,'doublebuffer','on');%消除振动
drawnow;
end

b=0;%设定电机反转的条件
db=0.015;
while s<20      %条件表达式  (当10<s<20时，电机反转，门下降)

b=b-db;
  xa1=18+abs(2*sin(a+b));
  xa2=25+2*sin(a+b);
  ya1=32.5+5*cos(a+b);
  ya2=32.5+5*cos(a+b);%设定sig1的两端点坐标（sig1是对应0的线）
  xb1=18+2*abs(sin(a+pi+b));
  xb2=25+2*sin(a+pi+b);
  yb1=32.5+5*cos(a+pi+b);
  yb2=32.5+5*cos(a+pi+b);%设定sig2的两端点坐标（sig2是对应pi的线）
  xc1=18+abs(2*sin(a+pi/2+b));
  xc2=25+2*sin(a+pi/2+b);
  yc1=32.5+5*cos(a+pi/2+b);
  yc2=32.5+5*cos(a+pi/2+b);%设定sig3的两端点坐标（sig3是对应pi/2的线）
  xd1=18+2*abs(sin(a-pi/2+b));
  xd2=25+2*sin(a-pi/2+b);
  yd1=32.5+5*cos(a-pi/2+b);
  yd2=32.5+5*cos(a-pi/2+b);%设定sig4的两端点坐标（sig4是对应-pi/2的线）

  xe1=18+abs(2*sin(a+pi/4+b));
  xe2=25+2*sin(a+pi/4+b);
  ye1=32.5+5*cos(a+pi/4+b);
  ye2=32.5+5*cos(a+pi/4+b);%设定sig5的两端点坐标（sig5是对应pi/4的线）
  xf1=18+2*abs(sin(a+pi*3/4+b));
  xf2=25+2*sin(a+pi*3/4+b);
  yf1=32.5+5*cos(a+pi*3/4+b);
  yf2=32.5+5*cos(a+pi*3/4+b);%设定sig6的两端点坐标（sig6是对应pi*3/4的线）
  xg1=18+abs(2*sin(a-pi*3/4+b));
  xg2=25+2*sin(a-3*pi/4+b);
  yg1=32.5+5*cos(a-3*pi/4+b);
  yg2=32.5+5*cos(a-3*pi/4+b);%设定sig7的两端点坐标（sig7是对应-3*pi/4的线）
  xh1=18+2*abs(sin(a-pi/4+b));
  xh2=25+2*sin(a-pi/4+b);
  yh1=32.5+5*cos(a-pi/4+b);
  yh2=32.5+5*cos(a-pi/4+b);%设定sig8的两端点坐标（sig8是对应-pi/4的线）
  %绘制电机表面各线条的运动
  set(sig1,'xdata',[xa1;xa2],'ydata',[ya1;ya2]);
  set(sig2,'xdata',[xb1;xb2],'ydata',[yb1;yb2]);
  set(sig3,'xdata',[xc1;xc2],'ydata',[yc1;yc2]);
  set(sig4,'xdata',[xd1;xd2],'ydata',[yd1;yd2]);
  set(sig5,'xdata',[xe1;xe2],'ydata',[ye1;ye2]);
  set(sig6,'xdata',[xf1;xf2],'ydata',[yf1;yf2]);
  set(sig7,'xdata',[xg1;xg2],'ydata',[yg1;yg2]);
  set(sig8,'xdata',[xh1;xh2],'ydata',[yh1;yh2]);

s=s+ds;
set(g0,'xdata',[49;48],'ydata',[15;10]);      %绘制闸刀的换向运动
set(door,'xdata',[25;25],'ydata',[35-s;25-s]);%绘制门的向下运动
set(d1,'xdata',[25;25],'ydata',[27.5;35-s]);  %绘制门顶绳索的向下运动
set(f1,'xdata',[25;37],'ydata',[30-s;30-s]);  %绘制门和电阻之间两根导线的运动
set(f2,'xdata',[35;35],'ydata',[45;30-s]);
set(j9,'xdata',[36;37],'ydata',[30.5-s;30-s]);%绘制上箭头的向下运动
set(j10,'xdata',[36;37],'ydata',[29.5-s;30-s]);%绘制下箭头的向下运动
set(gcf,'doublebuffer','on');%消除振动
drawnow;
end