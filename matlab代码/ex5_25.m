[x,y]=meshgrid(-5:0.1:5);
z=cos(x).*cos(y).*exp(-sqrt(x.^2+y.^2)/4);
surf(x,y,z);shading interp;
pause                 %≥Ã–Ú‘›Õ£
i=find(x<=0&y<=0);
z1=z;z1(i)=NaN;
surf(x,y,z1);shading interp;
