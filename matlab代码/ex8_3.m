format long;
fx=inline('exp(-x)');
[I,n]=quad(fx,1,2.5,1e-10)
