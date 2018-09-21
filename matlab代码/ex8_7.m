f=inline('sqrt(x.^3+2*x.^2-x+12)+(x+5).^(1/6)+5*x+2');
g=inline('(3*x.^2+4*x-1)./sqrt(x.^3+2*x.^2-x+12)/2+1/6./(x+5).^(5/6)+5');
x=-3:0.01:3;
p=polyfit(x,f(x),5);          %用5次多项式p拟合f(x)
dp=polyder(p);                 %对拟合多项式p求导数dp
dpx=polyval(dp,x);            %求dp在假设点的函数值
dx=diff(f([x,3.01]))/0.01;   %直接对f(x)求数值导数
gx=g(x);                         %求函数f的导函数g在假设点的导数
plot(x,dpx,x,dx,'.',x,gx,'-');   %作图
