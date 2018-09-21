
%Animation：rotate peak
%by dynamic
%see also http://www.matlabsky.com
%
figure('name','三维动画 旋转的山峰——Matlabsky');
%绘制三维曲面
[X,Y,Z]=peaks(14); 
surfl(X,Y,Z);        
axis([-4 4 -4 4 -11 11]);      %建立坐标系
axis off;        %去除三维网格线
shading interp; 
colormap spring; 
m=moviein(13);     %创建帧矩阵m
for i=1:12        %命令生成图形
   view(-37.5+30*(i-1),25); 
    m(:,i)=getframe;    %捕获动画帧
end 
movie(m);     %回放动画

%Animation：rotate paraboloid
%by dynamic
%see also http://www.matlabsky.com
%
h0=figure('name','三维动画  旋转抛物面——Matlabsky');  
axis([-5 10 -5 10 -10 80])     %建立坐标系
hold on    %保持当前图形的所有特性
%定义三组坐标曲线
a=0:0.5:10; 
b=zeros(size(a)); 
c=a.^2;    
theta=pi/20; 
xx=a;      %设置三维长轴坐标数据
yy=b;      %设置三维宽轴坐标数据 
zz=c;        %设置三维高度数据
%画旋转抛物面
for i=1:40 
   M=[tan(i*theta) cos(i*theta) 0;-cos(i*theta) sin(i*theta) 0;0 0 1]; 
   temp=M*[a;b;c];     
   xx(i+1,:)=temp(1,:);yy(i+1,:)=temp(2,:);zz(i+1,:)=temp(3,:);    
   mesh(xx,zz,yy);   %绘制三维网格曲面
  axis off      %去掉三维网格线
  pause(0.1)   %每次旋转停顿0.1秒
  if i==26   %设置旋转次数
       break 
   end 
end
