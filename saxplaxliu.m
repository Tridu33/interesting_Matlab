%ŒÂ–«∫Ï∆Ï
function varargout=saxplaxliu(varargin)
x=[0 0 40 40 0];
y=[0 13 13 0 0];
k=40/13;
fill(x,y,'r')
hold on
plot(x,y,'r')
axis([0 40 0 13])
seta=pi/6;
R=1.5;R2=0.55;x0=7;y0=9;seta=0;
fliu(R,R2,x0,y0,seta,k)
R=0.6;R2=0.23;x0=15;y0=11.6;seta=-pi/20;
fliu(R,R2,x0,y0,seta,k)
R=0.6;R2=0.23;x0=20;y0=10;seta=pi/20;
fliu(R,R2,x0,y0,seta,k)
R=0.6;R2=0.23;x0=19;y0=7;seta=pi/25;
fliu(R,R2,x0,y0,seta,k)
R=0.6;R2=0.23;x0=16;y0=5;seta=-pi/10;
fliu(R,R2,x0,y0,seta,k)
axis off 
function fliu(R,R2,x0,y0,seta,k)
x=zeros(1,10);
y=x;
for i=1:5
x(2*(i-1)+1)=R*cos(pi/2+2*pi/5*(i-1)+seta);
x(2*i)=R2*cos(pi/2+2*pi/5*(i-1)+pi/5+seta);
y(2*(i-1)+1)=R*sin(pi/2+2*pi/5*(i-1)+seta);
y(2*i)=R2*sin(pi/2+2*pi/5*(i-1)+pi/5+seta);
end
x(11)=x(1);
y(11)=y(1);
x=x*k+x0;
y=y+y0;
fill(x,y,[1 0.7 0])
plot(x,y,'y')