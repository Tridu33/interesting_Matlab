xmax=1;
ymax=1
figure('name','–›œÎÃ”£°');
fill([-2.5,2,2,-2.5],[-2,-2,-1.2,-1.2],'g');
hold on;
fill([-xmax-0.3,-xmax+0.3,-xmax+0.3,-xmax-0.3],[-2*ymax+0.1,-2*ymax+0.1,-2*ymax+0.4,-2*ymax+0.4],[0,0,0.5]);
hold on;
fill([-xmax-0.2,-xmax+0.2,-xmax+0.2,-xmax-0.2],[-2*ymax+0.4,-2*ymax+0.4,-2*ymax+0.6,-2*ymax+0.6],[0,0.5,0]);
hold on;
fill([-xmax-0.05,-xmax+0.05,-xmax+0.15,-xmax+0.2],[-2*ymax+0.6,-2*ymax+0.6,-ymax,-ymax],[0,0.5,0]);
hold on;
axis('on');
x0=-xmax+0.15;
y0=-ymax;
x1=2;
y1=4;
head=line(x0,y0,'color','r','linestyle','^','erasemode','xor','markersize',5);
body=line(x1,y1,'color','r','linestyle','<','erasemode','xor','markersize',20);
t=0;
dt=0.001;
v=1;
v0=2;
x=x0;
y=y0;
while y<=y1
t=t+dt;
xx=x1-v*t;
l=sqrt((y1-y)^2+(2-x-v*t)^2);
vy=v0*(y1-y)/l;
vx=v0*(2-x-v*t)/l;
y=y+vy*dt;
x=x+vx*dt;
set(head,'xdata',x,'ydata',y);
set(body,'xdata',xx,'ydata',y1);

drawnow;
end
t=0;
while t<0.05
t=t+0.01;
x1=x-(0.5+5*t);
x2=x-(0.2+2 *t);
x3=x-(0.6+6*t);
x4=x-(0.1+t);
x5=x;
x6=x+(0.05+0.5*t);
x7=x+(0.3+3*t);
x8=x+(0.2+2*t);
x9=x+(0.4+4*t);
x12=x+(0.1+t);
x10=x;
x11=x-(0.1+t);

y1=y+(0.1+t);
y2=y;
y3=y-(0.5+5*t);
y4=y-(0.2+2*t);
y5=y-(0.5+5*t);
y6=y-(0.3+3*t);
y7=y-(0.4+4*t);
y8=y;
y9=y+(0.1+t);
y12=y+(0.2+2*t);
y10=y+(0.5+5*t);
y11=y+(0.1+t);

fill([x1,x2,x3,x4,x5,x6,x7,x8,x9,x12,x10,x11],[y1,y2,y3,y4,y5,y6,y7,y8,y9,y12,y10,y11],'r');
hold on;

end