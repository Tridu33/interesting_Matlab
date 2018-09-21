%Clear

rectangle('position',[12,8.5,2,0.3],'FaceColor',[0.5,0.3,0.4]);

axis([0,15,-1,10]);

%画顶板

hold on

plot([13,13],[7,8.5],'r','linewidth',2);

%画直线

y=2:.2:7;

M=length(y);

x=12+mod(1:M,2)*2;

x(1)=13;

x(end-3:end)=13;

D=plot(x,y);         

%弹簧

C=0:.1:2*pi;r=0.35;

t1=r*sin(C);

F1=fill(13+r*cos(C),2+t1,'r');

% 球

set(gca,'ytick',[0:2:9]);

set(gca,'yticklabels',num2str([-1:3]'));

plot([0,15],[3.3,3.3],'black');

H1=plot([0,13],[3.3,3.3],'y');

% 句柄[黄线]

Q=plot(0,3.8,'color','r');

% 运动曲线;

td=[];yd=[];

T=0;

text(2,9,'理想中的弹簧振子简谐振动','fontsize',16);

set(gcf,'doublebuffer','on');

while T<12;

pause(0.2);

Dy=(3/2-1/2*sin(pi*T))*1/2;

Y=-(y-2)*Dy+7;

Yf=Y(end)+t1;

td=[td,T];yd=[yd,Y(end)];

set(D,'ydata',Y);

set(F1,'ydata',Yf,'facecolor',rand(1,3));

set(H1,'xdata',[T,13],'ydata',[Y(end),Y(end)]);

set(Q,'xdata',td,'ydata',yd) ;

T=T+0.1;

end