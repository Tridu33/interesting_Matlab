t=0:pi/20:2*pi;
y1=sin(t);
y2=cos(t);
figh=figure('Position',[30,100,800,350]);
axes('GridLineStyle','-.','XLim',[0,2*pi],'YLim',[-1,1]);
line('XData',t,'YData',y1,'LineWidth',2);
line(t,y2);
grid on
