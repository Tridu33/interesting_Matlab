fuction main
clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%主函数%%%%%%%%%%%%%%%%%%%%%%%%%%%
bTimeStep = 0.1; %%重绘时间间隔
bSaveAVI = 1;  %%是否将重绘过程保存到视频文件
initDegree = 0; %%初始位置，位于零度角
if bSaveAVI
    aviname = input('input the file name for avi: ','s');
    aviobj=avifile(aviname);   %定义一个视频文件用来存动画
    aviobj.quality=60;
    aviobj.Fps=5;
end

r = 1; %%背景图中圆的半径
DrawBackGround(r); %%画背景
hold on;
[xcoor,ycoor] = GetCorrByDegree(r, TransDegToRad(initDegree)); %%画初始位置，零度角
x = [0 xcoor];
y = [0 ycoor];
h = plot(x,y,'g-');

degreeStepForTest = 20;%%用于测试用的角度增量
for sita = initDegree+degreeStepForTest:degreeStepForTest:360  
    [xcoor,ycoor] = GetCorrByDegree(r, TransDegToRad(sita)); %%获取当前的角度对应的坐标
    x = [0 xcoor];
    y = [0 ycoor];
    set(h,'XData',x,'YData',y); %%重置绘图对象
    drawnow; %%重绘
    
    if bSaveAVI 
        frame=getframe(gca);   %把图像存入视频文件中
        im=frame2im(frame);
        aviobj=addframe(aviobj,im);
    end
    
    pause(bTimeStep); %%暂停间隔
end

if bSaveAVI
    aviobj=close(aviobj); %%关闭视频文件句柄
end

%%%%%%%%%%%%%%%%%%%%%%%%%%子函数%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function radian = TransDegToRad(degree)
%%将角度转换为弧度
radian = degree * pi / 180;

function [x y] = GetCorrByDegree(R, Degree)
%%根据角度和半径计算当前点的坐标
x = R * cos(Degree);
y = R * sin(Degree);

function DrawBackGround(r)
%%%画背景图
x = linspace(-r,r,1000);
y1 = sqrt(r^2-x.^2);
plot(x,y1,'b-'); %%画上半圆
hold on;
y2 = -sqrt(r^2-x.^2); %%画下半圆
plot(x,y2,'b-');
axis square;

plot([0 0],[-r r],'b-'); %%画纵直径
plot([-r r],[0 0],'b-'); %%画横直径
axis off;
hold off;