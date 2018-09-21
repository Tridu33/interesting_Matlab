X=input('Enter X:');
E=zeros(size(X));
F=eye(size(X));
n=1;
while norm(F,1)>0
   E=E+F;
   F=F*X/n;
   n=n+1;
end
E
xpm(X)            %调用MATLAB矩阵指数函数求矩阵指数
