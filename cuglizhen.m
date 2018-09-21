[x,y]=meshgrid(-10:0.01:10);
z=-(17*x.^2-16*y.*abs(x)+17.*y.^2);
[c,h]=contourf(z,100);
set(h,'linestyle','none')
