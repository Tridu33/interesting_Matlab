sf_tetris2%俄罗斯方块实例，卡死人
xpbombs%
vibes%
teapotdemo%
logo%
travel%
life%MATLAB's version of Conway's Game of Life. 
makevase%Generate and plot a surface of revolution. 
truss%Animation of a bending bridge truss. 
codec
%The codec acts like an encoder/decoder for messages
%using the letters of the alphabet
fifteen%A sliding puzzle of fifteen squares and sixteen slots. 
xpquad %Superquadrics plotting demonstration. 
wrldtrv %Show great circle flight routes around the globe. 
spy %女巫，有的是小狗
cplxdemo%复杂的XYZ立体图形~黎曼曲面的平面效果 
lorenz % Lorenz吸引子动画显示 
%{
solve('x^2+p*x+q=0','x')
 
ans =
 
 - p/2 - (p^2 - 4*q)^(1/2)/2
   (p^2 - 4*q)^(1/2)/2 - p/2
 
pretty(ans)
 
  +-                     -+ 
  |          2       1/2  | 
  |    p   (p  - 4 q)     | 
  |  - - - -------------  | 
  |    2         2        | 
  |                       | 
  |          2       1/2  | 
  |    p   (p  - 4 q)     | 
  |  - - + -------------  | 
  |    2         2        | 
  +-                     -+
%}
% 多行注释: 选中要注释的若干语句, 编辑器菜单Text->Comment, 或者快捷键Ctrl+R
% 
% 取消注释: 选中要取消注释的语句, 编辑器菜单Text->Uncomment, 或者快捷键Ctrl+T
% 
image
%会看到一个小男孩
%这张图片里还隐藏着另外14张图片，这些图片都隐藏在这个小男孩的图片数据中： ,
% 前两种是MathWorks的员工的宠物，第三张是3阶希尔伯特方阵的逆矩阵，第四张
% MathWorks的早起的logo，如果有兴趣的话可以读一下开发者的博客，里边有介绍
% 得到这些图片的方法和图片相关的信息 
syms x;
g=1/(x^2+2*x-3);
ezplot(g,-10,10);
%囧函数

%乳房曲线
[X, Y] = meshgrid(0.01:0.01:1, 0.01:0.01:1); 
Zfun =@(x,y)12.5*x.*log10(x).*y.*(y-1)+exp(-((25 ... 
*x - 25/exp(1)).^2+(25*y-25/2).^2).^3)./25; 
Z = Zfun(X,Y); 
figure; 
surf(Y,Z,X,'FaceColor',[1 0.75 0.65],'linestyle','none'); 
hold on 
surf(Y+0.98,Z,X,'FaceColor',[1 0.75 0.65],'linestyle','none'); 
axis equal; 
view([116 30]); 
camlight; 
lighting phong; % 设置光照和光照模式 





