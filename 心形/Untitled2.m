%ÐÄÐÎ
x=[-1.65:0.00001:1.65];
hold on;
plot(x,(sqrt(cos(x)).*cos(200.*x)+sqrt(abs(x))-0.7).*(4-x.*x).^0.01,'r')
axis([-5 5 -5 5]);
x=[-4.5:0.00001:4.5];
plot(x,sqrt(4.5-x.^2),x,-sqrt(4.5-x.^2))