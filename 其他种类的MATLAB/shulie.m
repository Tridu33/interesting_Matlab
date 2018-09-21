a=1;
x=[];
for i= 1:101;
    a=sqrt(2*a);
    x=[x,a];
end
x;
subplot(1,2,1);plot(x,'LineWidth',5);title('x');%子图，1行2列第一幅，画数列，线宽
text(1,1,'an+1=sqrt(2*an)');%在（1，1）点显示表达式
axis([-1,101,0.9,2.1]);%轴，先X后Y
grid on;%描边
subplot(1,2,2);plot(x,'.','color','r');%颜色红，可以kryg,默认b蓝色
axis([-1,101,0.9,2.1]);
title('x');
gtext('an+1=sqrt(2*an)');%鼠标定位点击就送方程表达式
grid on;
