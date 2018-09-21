%%成功做动画
clear
clc
%http://blog.csdn.net/love_786/article/details/52014673
%http://www.cnblogs.com/bacazy/archive/2012/12/15/2819172.html
writerObj = VideoWriter('peaks.avi');writerObj.FrameRate = 30;
open(writerObj);
Z = peaks;
surf(Z);
axis tight
set(gca,'nextplot','replacechildren');
set(gcf,'Renderer','zbuffer');
for k = 1:20
surf(sin(2*pi*k/20)*Z)
pause(1)
frame = getframe;
writeVideo(writerObj,frame);
end
close(writerObj);