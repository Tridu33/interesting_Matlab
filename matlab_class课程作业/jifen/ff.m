function  [y]=ff(t)
a=7782.5;b=7721.5;
y=sqrt(a^2*sin(t).^2+b^2*cos(t).^2)