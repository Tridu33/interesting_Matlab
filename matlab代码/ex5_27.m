[X,Y,Z]=peaks(30); 
surf(X,Y,Z)
axis([-3,3,-3,3,-10,10])
axis off;
shading interp;
colormap(hot);
m=moviein(20);            %建立一个20列大矩阵
for i=1:20
view(-37.5+24*(i-1),30)      %改变视点
m(:,i)=getframe;            %将图形保存到m矩阵
end 
movie(m,2);                 %播放画面2次
