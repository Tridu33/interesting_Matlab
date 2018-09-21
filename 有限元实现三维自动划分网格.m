% http://myangie.blog.sohu.com/6192144.html
% 在开发有限元程序的时候，
% 首先遇到的问题就是实现自动划分网格（meshgrid），
% matlab可以实现这一功能，它的基本原理就是
% 根据图论和邻接矩阵的原理利用gplot函数和sparse稀疏矩阵实现的，
% 但是它只能实现二维！本人重新编写了一个程序，
% 可以实现三维的网格自动划分
% （包括三角形单元、矩形单元和六面体单元），
% 程序如下：
a1=zeros(m1*n1);
b1=zeros(m1*n1);
XY1=zeros(m1*n1,2);
x1=zeros(1,m1*n1);
y1=zeros(1,m1*n1);
z1=zeros(1,m1*n1);

for k=1:n1
    for i=1:m1
        x1(i+(k-1)*m1)=xmin1+(k-1)*(xmax1-xmin1)/(n1-1);
        z1(i+(k-1)*m1)=zmin1+(i-1)*(zmax1-zmin1)/(m1-1);
    end
end
clear k i

a1(m1,m1)=2;
a1((n1-1)*m1+1,(n1-1)*m1+1)=2;
a1(1,1)=3;
a1(n1*m1,n1*m1)=3;
for i=1:(n1-2)
    a1(i*m1+1,i*m1+1)=4;
    a1((i+1)*m1,(i+1)*m1)=4;
end
clear i

for j=2:(m1-1)
    a1(j,j)=4;
    a1((n1-1)*m1+j,(n1-1)*m1+j)=4;
end
clear j

for i=1:(n1-2)
    for j=2:(m1-1)
        a1(i*m1+j,i*m1+j)=6;
    end
end
clear i j

a1=sparse(a1);

for i=1:(n1-1)*m1-1
    b1(i,i+1)=-1;
end
clear i

for i=1:(n1-1)*m1
    b1(i,i+m1)=-1;
end
clear i

for i=1:(n1-1)*m1-1
    b1(i,i+m1+1)=-1;
end
clear i

for k=1:(n1-1)
    for h=1:(n1-1)
        b1(m1*k,m1*h+1)=0;
    end
end
clear k h

for i=(n1-1)*m1+1:n1*m1-1
    b1(i,i+1)=-1;
end   
clear i

b1=sparse(b1);
b1=a1+b1'+b1;

clear a1
a1=sparse(b1);
clear b1
XY1=[x1',y1',z1'];

a2=zeros(m2*n2);
b2=zeros(m2*n2);
XY2=zeros(m2*n2,2);
x2=0.5*ones(1,m2*n2);    
y2=zeros(1,m2*n2);
z2=zeros(1,m2*n2);

for k=1:n2
    for i=1:m2
        z2(i+(k-1)*m2)=zmin2+(k-1)*(zmax2-zmin2)/(n2-1);
        y2(i+(k-1)*m2)=ymin2+(i-1)*(ymax2-ymin2)/(m2-1);
    end
end
clear k i

a2(m2,m2)=2;
a2((n2-1)*m2+1,(n2-1)*m2+1)=2;
a2(1,1)=3;
a2(n2*m2,n2*m2)=3;

for i=1:(n2-2)
    a2(i*m2+1,i*m2+1)=4;
    a2((i+1)*m2,(i+1)*m2)=4;
end
clear i

for j=2:(m2-1)
    a2(j,j)=4;
    a2((n2-1)*m2+j,(n2-1)*m2+j)=4;
end
clear j

for i=1:(n2-2)
    for j=2:(m2-1)
        a2(i*m2+j,i*m2+j)=6;
    end
end
clear i j

a2=sparse(a2);

for i=1:(n2-1)*m2-1
    b2(i,i+1)=-1;
end
clear i

for i=1:(n2-1)*m2
    b2(i,i+m2)=-1;
end
clear i

for i=1:(n2-1)*m2-1
    b2(i,i+m2+1)=-1;
end
clear i

for k=1:(n2-1)
    for h=1:(n2-1)
        b2(m2*k,m2*h+1)=0;
    end
end
clear k h

for i=(n2-1)*m2+1:n2*m2-1
    b2(i,i+1)=-1;
end   
clear i

b2=sparse(b2);
b2=a2+b2'+b2;
clear a2
a2=sparse(b2);
clear b2
XY2=[x2',y2',z2'];

a3=zeros(m3*n3);
b3=zeros(m3*n3);
XY3=zeros(m3*n3,2);
x3=1.5*ones(1,m3*n3);
y3=zeros(1,m3*n3);
z3=zeros(1,m3*n3);

for k=1:n3
    for i=1:m3
        z3(i+(k-1)*m3)=zmin3+(k-1)*(zmax3-zmin3)/(n3-1);
        y3(i+(k-1)*m3)=ymin3+(i-1)*(ymax3-ymin3)/(m3-1);
    end
end
clear k i

a3(m3,m3)=2;
a3((n3-1)*m3+1,(n3-1)*m3+1)=2;
a3(1,1)=3;
a3(n3*m3,n3*m3)=3;

for i=1:(n3-2)
    a3(i*m3+1,i*m3+1)=4;
    a3((i+1)*m3,(i+1)*m3)=4;
end
clear i

for j=2:(m3-1)
    a3(j,j)=4;
    a3((n3-1)*m3+j,(n3-1)*m3+j)=4;
end
clear j

for i=1:(n3-2)
    for j=2:(m3-1)
        a3(i*m3+j,i*m3+j)=6;
    end
end
clear i j

a3=sparse(a3);

for i=1:(n3-1)*m3-1
    b3(i,i+1)=-1;
end
clear i

for i=1:(n3-1)*m3
    b3(i,i+m3)=-1;
end
clear i

for i=1:(n3-1)*m3-1
    b3(i,i+m3+1)=-1;
end
clear i

for k=1:(n3-1)
    for h=1:(n3-1)
        b3(m3*k,m3*h+1)=0;
    end
end
clear k h

for i=(n3-1)*m3+1:n3*m3-1
    b3(i,i+1)=-1;
end   
clear i

b3=sparse(b3);
b3=a3+b3'+b3;
clear a3
a3=sparse(b3);
clear b3
XY3=[x3',y3',z3'];

a4=zeros(m4*n4);
b4=zeros(m4*n4);
XY4=zeros(m4*n4,2);
x4=0*ones(1,m4*n4);    
y4=zeros(1,m4*n4);
z4=zeros(1,m4*n4);

for k=1:n4
    for i=1:m4
        z4(i+(k-1)*m4)=zmin4+(k-1)*(zmax4-zmin4)/(n4-1);
        y4(i+(k-1)*m4)=ymin4+(i-1)*(ymax4-ymin4)/(m4-1);
    end
end
clear k i

a4(m4,m4)=2;
a4((n4-1)*m4+1,(n4-1)*m4+1)=2;
a4(1,1)=3;
a4(n4*m4,n4*m4)=3;

for i=1:(n4-2)
    a4(i*m4+1,i*m4+1)=4;
    a4((i+1)*m4,(i+1)*m4)=4;
end
clear i

for j=2:(m4-1)
    a4(j,j)=4;
    a4((n4-1)*m4+j,(n4-1)*m4+j)=4;
end
clear j

for i=1:(n4-2)
    for j=2:(m4-1)
        a4(i*m4+j,i*m4+j)=6;
    end
end
clear i j

a4=sparse(a4);

for i=1:(n4-1)*m4-1
    b4(i,i+1)=-1;
end
clear i

for i=1:(n4-1)*m4
    b4(i,i+m4)=-1;
end
clear i

for i=1:(n4-1)*m4-1
    b4(i,i+m4+1)=-1;
end
clear i

for k=1:(n4-1)
    for h=1:(n4-1)
        b4(m4*k,m4*h+1)=0;
    end
end
clear k h

for i=(n4-1)*m4+1:n4*m4-1
    b4(i,i+1)=-1;
end   
clear i

b4=sparse(b4);
b4=a4+b4'+b4;
clear a4
a4=sparse(b4);
clear b4
XY4=[x4',y4',z4'];

a5=zeros(m5*n5);
b5=zeros(m5*n5);
XY5=zeros(m5*n5,2);
x5=2*ones(1,m5*n5);
y5=zeros(1,m5*n5);
z5=zeros(1,m5*n5);

for k=1:n5
    for i=1:m5
        z5(i+(k-1)*m5)=zmin5+(k-1)*(zmax5-zmin5)/(n5-1);
        y5(i+(k-1)*m5)=ymin5+(i-1)*(ymax5-ymin5)/(m5-1);
    end
end
clear k i

a5(m5,m5)=2;
a5((n5-1)*m5+1,(n5-1)*m5+1)=2;
a5(1,1)=3;
a5(n5*m5,n5*m5)=3;

for i=1:(n5-2)
    a5(i*m5+1,i*m5+1)=4;
    a5((i+1)*m5,(i+1)*m5)=4;
end
clear i

for j=2:(m5-1)
    a5(j,j)=4;
    a5((n5-1)*m5+j,(n5-1)*m5+j)=4;
end
clear j

for i=1:(n5-2)
    for j=2:(m5-1)
        a5(i*m5+j,i*m5+j)=6;
    end
end
clear i j

a5=sparse(a5);

for i=1:(n5-1)*m5-1
    b5(i,i+1)=-1;
end
clear i

for i=1:(n5-1)*m5
    b5(i,i+m5)=-1;
end
clear i

for i=1:(n5-1)*m5-1
    b5(i,i+m5+1)=-1;
end
clear i

for k=1:(n5-1)
    for h=1:(n5-1)
        b5(m5*k,m5*h+1)=0;
    end
end
clear k h

for i=(n5-1)*m5+1:n5*m5-1
    b5(i,i+1)=-1;
end   
clear i

b5=sparse(b5);
b5=a5+b5'+b5;
clear a5
a5=sparse(b5);
clear b5
XY5=[x5',y5',z5'];

A1=a1;
xy1=XY1;
A2=a2;
xy2=XY2;
A3=a3;
xy3=XY3;
A4=a4;
xy4=XY4;
A5=a5;
xy5=XY5;

[i1,j1] = find(A1);
[ignore, p1] = sort(max(i1,j1));
i1=i1(p1);
j1=j1(p1);

[i2,j2] = find(A2);
[ignore, p2] = sort(max(i2,j2));
i2=i2(p2);
j2=j2(p2);

[i3,j3] = find(A3);
[ignore, p3] = sort(max(i3,j3));
i3=i3(p3);
j3=j3(p3);

[i4,j4] = find(A4);
[ignore, p4] = sort(max(i4,j4));
i4=i4(p4);
j4=j4(p4);

[i5,j5] = find(A5);
[ignore, p5] = sort(max(i5,j5));
i5=i5(p5);
j5=j5(p5);

% Create a long, NaN-separated list of line segments,
% rather than individual segments.

X1 = [ xy1(i1,1) xy1(j1,1) repmat(NaN,size(i1))]';
Y1 = [ xy1(i1,3) xy1(j1,3) repmat(NaN,size(i1))]';
Z1 = [ xy1(i1,2) xy1(j1,2) repmat(NaN,size(i1))]';

X2 = [ xy2(i2,1) xy2(j2,1) repmat(NaN,size(i2))]';
Y2 = [ xy2(i2,3) xy2(j2,3) repmat(NaN,size(i2))]';
Z2 = [ xy2(i2,2) xy2(j2,2) repmat(NaN,size(i2))]';

X3 = [ xy3(i3,1) xy3(j3,1) repmat(NaN,size(i3))]';
Y3 = [ xy3(i3,3) xy3(j3,3) repmat(NaN,size(i3))]';
Z3 = [ xy3(i3,2) xy3(j3,2) repmat(NaN,size(i3))]';

X4 = [ xy4(i4,1) xy4(j4,1) repmat(NaN,size(i4))]';
Y4 = [ xy4(i4,3) xy4(j4,3) repmat(NaN,size(i4))]';
Z4 = [ xy4(i4,2) xy4(j4,2) repmat(NaN,size(i4))]';

X5 = [ xy5(i5,1) xy5(j5,1) repmat(NaN,size(i5))]';
Y5 = [ xy5(i5,3) xy5(j5,3) repmat(NaN,size(i5))]';
Z5 = [ xy5(i5,2) xy5(j5,2) repmat(NaN,size(i5))]';

X1 = X1(:);
Y1 = Y1(:);
Z1 = Z1(:);

X2 = X2(:);
Y2 = Y2(:);
Z2 = Z2(:);

X3 = X3(:);
Y3 = Y3(:);
Z3 = Z3(:);

X4 = X4(:);
Y4 = Y4(:);
Z4 = Z4(:);

X5 = X5(:);
Y5 = Y5(:);
Z5 = Z5(:);

% Create the line properties string
cla;
if nargout==0,
        subplot('position',[0.05,0.05,0.5,0.8]);
        h1=plot3(X1,Y1,Z1);
        hold on;
        h2=plot3(X2,Y2,Z2);
        hold on;
        h3=plot3(X3,Y3,Z3);
        hold on;
        h4=plot3(X4,Y4,Z4);
        hold on;
        h5=plot3(X5,Y5,Z5);
       
else
    X1out = X1;
    Y1out = Y1;
    Z1out = Z1;
   
    X2out = X2;
    Y2out = Y2;
    Z2out = Z2;
   
    X3out = X3;
    Y3out = Y3;
    Z3out = Z3;
   
    X4out = X4;
    Y4out = Y4;
    Z4out = Z4;
   
    X5out = X5;
    Y5out = Y5;
    Z5out = Z5;
end

if nargin>2
    for k=1:nargin-3
        s=varargin{k};
try
    if isnumeric(varargin{k+1})
   
  set(h1,s,varargin{k+1});
  set(h2,s,varargin{k+1});
  set(h3,s,varargin{k+1});
  set(h4,s,varargin{k+1});
  set(h5,s,varargin{k+1});
 
    else
  set(h1,s);
  set(h2,s);
  set(h3,s);
  set(h4,s);
  set(h5,s);
    end
catch
end
    end
end









