%录制电影动画
for i=1:6
%
%这里输入我们的绘图命令
%
draw_human;
save i.mat i;
M(i) = getframe;
end
movie(M)
movie2avi(M,dianying);
%单帧显示方法
f = getframe(gcf);
colormap(f.colormap);
image(f.cdata); 
