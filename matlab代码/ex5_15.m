subplot(2,2,1);
ezplot('x^2+y^2-9');axis equal
subplot(2,2,2);
ezplot('x^3+y^3-5*x*y+1/5')
subplot(2,2,3);
ezplot('cos(tan(pi*x))',[ 0,1])
subplot(2,2,4);
ezplot('8*cos(t)','4*sqrt(2)*sin(t)',[0,2*pi])
