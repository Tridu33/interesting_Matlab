x=0:pi/100:2*pi;
y1=2*exp(-0.5*x);
y2=cos(4*pi*x);
plot(x,y1,x,y2)
title('x from 0 to 2{\pi}');             %加图形标题
xlabel('Variable X');                 %加X轴说明
ylabel('Variable Y');                  %加Y轴说明
text(0.8,1.5,'曲线y1=2e^{-0.5x}');      %在指定位置添加图形说明
text(2.5,1.1,'曲线y2=cos(4{\pi}x)'); 
legend('y1',' y2')                     %加图例
