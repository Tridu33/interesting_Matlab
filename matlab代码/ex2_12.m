p=[3,-7,0,5,2,-18];
A=compan(p);           %A的伴随矩阵
x1=eig(A)              %求A的特征值
x2=roots(p)                 %直接求多项式p的零点
