a=0;b=3*pi;
n=1000; h=(b-a)/n;
x=a; s=0; 
f0=exp(-0.5*x)*sin(x+pi/6);
for i=1:n
    x=x+h;
    f1=exp(-0.5*x)*sin(x+pi/6);
    s=s+(f0+f1)*h/2;
    f0=f1;
end
s
