x=0:0.01:1;
y=3.*x.*log10(x)-(1/30).*exp(-  ( (30.*x-30./exp(1)).^4));
plot(y,x)
grid on
axis equal