function f=fxy(x,y)
global ki;
ki=ki+1;              %ki用于统计被积函数的调用次数
f=exp(-x.^2/2).*sin(x.^2+y);
