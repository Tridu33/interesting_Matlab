function q=myfun(p)
x=p(1);
y=p(2);
q(1)=x-0.6*sin(x)-0.3*cos(y);
q(2)=y-0.6*cos(x)+0.3*sin(y);
