function [y,n]=gauseidel(A,b,x0,eps)
if nargin==3
    eps=1.0e-6;
elseif nargin<3
    error
    return
end      
D=diag(diag(A));    %求A的对角矩阵
L=-tril(A,-1);      %求A的下三角阵
U=-triu(A,1);       %求A的上三角阵
G=(D-L)\U;
f=(D-L)\b;
y=G*x0+f;
n=1;                  %迭代次数
while norm(y-x0)>=eps
    x0=y;
    y=G*x0+f;
    n=n+1;
end
