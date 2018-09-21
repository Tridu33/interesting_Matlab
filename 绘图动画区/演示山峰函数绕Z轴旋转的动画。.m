%演示山峰函数绕Z轴旋转的动画。

[X,Y,Z]=peaks(30);

>> surf(X,Y,Z)

>> axis([-3,3,-3,3,-10,10])

>> axis off

>> shading interp

>> colormap(hot)

>> M=moviein(20);          %建立一个20列的大矩阵

>> for i=1:20

view(-37.5+24*(i-1),30)    %改变视点

M(:,i)=getframe;           %将图形保存到M矩阵

end

>> movie(M,2)              %播放画面2次