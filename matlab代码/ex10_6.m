x=-pi:.1:pi;
y=sin(x);
y1=sin(x);
y2=cos(x);
h=line(x,y1,'LineStyle',':','Color','g');
line(x,y2,'LineStyle','--','Color','b');
xlabel('-\pi \leq \Theta \leq \pi')
ylabel('sin(\Theta)')
title('Plot of sin(\Theta)')
text(-pi/4,sin(-pi/4),'\leftarrow sin(-\pi\div4)','FontSize',12)
set(h,'Color','r','LineWidth',2)       %改变曲线1的颜色和线宽
