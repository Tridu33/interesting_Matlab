%

xs=linspace(0,3,1001);
ys=xs.*exp(-xs.^2)-1/5;
plot(xs,ys);
hold on;
plot([0,1],[0,0]);
