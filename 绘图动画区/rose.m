%上传不了图片过大【随机出现玫瑰图片的gif】
%步骤写好吧！
%1。网上下载不同的玫瑰花图片，尽量选小图片100*100的
%2.分别命名为1.jpg 2.jpg 。。。。。。。。。。。存到  rose.m相应路径下（我的是11个jpg文件）图片过多改我用*标记的行
%运行m文件。得到rose。gif
function rose
close all
clear
clc
Times=120;
%%初始化
h1=imread('1.jpg');h2=imread('2.jpg');h3=imread('3.jpg');h4=imread('4.jpg');
h5=imread('5.jpg');h6=imread('6.jpg');h7=imread('7.jpg');h8=imread('8.jpg');
h9=imread('9.jpg');h10=imread('10.jpg');h11=imread('11.jpg');%h12=imread('12.jpg'); %**************一样加
%%
    figure();
    axis off;
%      set (gcf,'Position',[100,100,900,900])
    set(gcf, 'menubar', 'none', 'toolbar', 'none'); % 不显示菜单栏和工具栏
    hold on
for i=1:Times
    H=randi(11,1,1);%****************几个11就改几
    if H==1
        H1=h1;
    elseif H==2
        H1=h2;
         elseif H==3
        H1=h3;
            elseif H==4
        H1=h4;
            elseif H==5
        H1=h5;
            elseif H==6
        H1=h6;
            elseif H==7
        H1=h7;
            elseif H==8
        H1=h8;
            elseif H==9
        H1=h9;
            elseif H==10
        H1=h10;
            elseif H==11
        H1=h11;
%             elseif H==12  %***************************后面一样加
%         H1=h12;
    end
     hh=randi(10,1,1)/20;hh1=randi(10,1,1)/20;
     axes('Position',[hh,hh1,hh+0.05,hh1+0.05]);
    imshow(H1);
    axis equal; axis off
    hold on
    pause(0.1);
    drawnow;
   
    MM(i)
end
hold off
msgbox('完成动画！！！','完成')
function MM(i)
     filename = 'rose.gif';
     f = getframe(gcf);  
     imind = frame2im(f);
    [imind,cm] = rgb2ind(imind,256);
    if i==1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.05);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.1);

    end
