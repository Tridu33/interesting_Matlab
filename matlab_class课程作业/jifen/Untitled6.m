clear;
clc
ts=linspace(0,35,5e5);
th0=85/180*pi;x0=[0,th0];
[TsL,XsL]=ode45(@fdxL,ts,x0);thsL=XsL(:,2);
[TsN,XsN]=ode45(@fdxN,ts,x0);thsN=XsN(:,2);
