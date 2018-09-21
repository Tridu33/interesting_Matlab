%https://mp.weixin.qq.com/s/PQxSp-_lvgMOkZ2wK6ro8g
n=100;
x=linspace(-3,3,n); %昨天help linspace看了吗0.0
y=linspace(-3,3,n);
z=linspace(-3,3,n);
[X,Y,Z]=ndgrid(x,y,z);
F=((-(X.^2).*(Z.^3) -(9/80).*(Y.^2).*(Z.^3))+((X.^2)+(9/4).*(Y.^2)+(Z.^2)-1).^3); 
%心型函数，《高数(同济大学版)-附录》，是不是回忆起来了什么...
isosurface(F,0)
lighting phong
caxis  
axis equal
axis off
colormap('flag'); %颜色
set(0,'defaultfigurecolor','w')
%设置背景为白色
j=0
for i=60:20:420
view([i 30]); %视角
j=j+1;
saveas(gcf,[num2str(j) '.jpg'])
end


tr = strcat(num2str(i), '.jpg');
    A=imread(str);
    [I,map]=rgb2ind(A,256);
    %因为 GIF 文件不支持三维数据，所以应调用 rgb2ind，使用颜色图 map 将图像中的 RGB 数据转换为索引图像 A
    if(i==1)
        imwrite(I,map,filename,'DelayTime',0.1,'LoopCount',Inf)
    else
        imwrite(I,map,filename,'WriteMode','append','DelayTime',0.3)
        %%imwrite 将 GIF 文件写入您的当前文件夹。名称-值对组 'LoopCount',Inf 使动画连续循环。
        %%'DelayTime',0.11 在每个动画图像显示之间指定了0.1秒的时滞。
    end
end