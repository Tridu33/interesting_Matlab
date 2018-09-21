function RandomDisplayJiong()
close all;clear all;clc;
axis off; % 不显示坐标轴
set(gcf,'color',[0 0 0]); 
% 设置背景颜色为黑色
set(gcf,'numberTitle','off','name','随机囧图'); % 标题控制
set(gcf,'menubar','none','toolbar','none','Resize','off'); 
% 不显示 menubar 和 toolbar, 不可改变大小
for k = 1:100 % 100次循环
% 绘出一个"囧"字文本框, 色彩大小旋转随机
h = text(rand(),rand(),'囧','color',rand(1,3),'Rotation',...
rand()*360,'fontname','隶书','fontsize',5+20*rand() );
pause(0.1); % 停顿0.1s
end
end