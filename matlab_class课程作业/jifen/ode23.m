%调用fddy的求数值积分ode例子。
clear;
clc;
y0=0;
ti=linspace(0,100,100010);
[T,Y]=ode45(@fddy,ti,y0);
plot(T,Y);

