function [rho,theta]=tran(x,y)
rho=sqrt(x*x+y*y);
theta=atan(y/x);
