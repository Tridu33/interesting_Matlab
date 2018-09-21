%% ´íÇÐ±ä»»
\x=[1,2,2,1,1];
y=[1,1,2,2,1];
f=linspace(1,9,37);

plot(x,y,'.r')
 axis([0,20,0,10]);
hold on

for i=1:37

a=f(i);

x1=x+a*y;

y1=y+0.3*a*x;

plot(x1,y1)

pause(0.2)

end

%% ±ÈÀý±ä»»
x=[1,2,2,1,1];

y=[1,1,2,2,1];

f=linspace(1,9,37);

axis([0,20,0,20])

hold on

for i=1:37

a=f(i);

x1=a*x;

y1=a*y;

plot(x1,y1)

pause(0.2)

end



%%  xuanzhuan
 x=linspace(-2,2,21);

 y=x.^2;

 f=linspace(0,2*pi,37);

 axis([-5,5,-5,5]);

 hold on

for i=1:37

a=f(i);

x1=x*cos(a)+y*sin(a);

y1=y*cos(a)-x*sin(a);

plot(x1,y1);

pause(0.2)

end
%% pingyi
 x=linspace(0,2*pi,37);

xt=linspace(0,2*pi,37);

x=cos(xt);

y=sin(xt);

plot(x,y,'r:');

axis([-2,15,-2,15]);

hold on

for i=1:10

x=x+1;

y=y+1;

plot(x,y)

pause(0.2)

end