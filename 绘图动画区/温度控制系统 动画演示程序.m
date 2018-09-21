hf=figure('name','温度控制系统','color',[.96 .96 .96]);%设置标题名字
%该温度控制系统保证温度在60－100摄氏度,当温度高于100摄氏度时，开始冷却；当温度低于60度时，开始加热；分别有指示灯指示
axis([-1 1 -1 1]);
axis('off');hold on;
x1=[0.2 0.2 0.4 0.4];
y1=[-0.46 -1 -1 -0.46];
t=-0.46;%存储温度纵坐标
k=1;k1=1;%k为运行标志位，当k=1时，运行；当k=0时，停止；k1为温度上下降标志位，当k1=1时，温度上升;当k1=0时，温度下降
line([0.2;0.2],[1;-1],'color','k','linewidth',2); %画温度区域左边
line([0.2;0.4],[-1;-1],'color','k','linewidth',2);%画温度区域下边
line([0.4;0.4],[1;-1],'color','k','linewidth',2);%画温度区域右边
line([0.2;0.4],[1;1],'color','k','linewidth',2);%画温度区域上边
line([0.4;0.5],[1;1],'color','r','linewidth',2);%刻度标记100
text(0.5,1,'100摄氏度','color','r');
line([0.4;0.5],[0.2;0.2],'color','b','linewidth',2);%刻度标记60
text(0.5,0.2,'60摄氏度','color','b');
line([0.4;0.5],[-0.46;-0.46],'color','g','linewidth',2);%刻度标记27
text(0.5,-0.46,'室温27摄氏度','color','g');
pp=line([0.2;0.4],[-0.46;-0.46],'color','r','linewidth',3);
Fun1=plot(-0.95,0.6,'color','k','marker','.','markersize',30);%加热显示
text(-1,0.5,'加热');
Fun2=plot(-0.5,0.6,'color','k','marker','.','markersize',30);%冷却显示
text(-0.55,0.5,'冷却');
Fun3=plot(-0.95,0.2,'color','k','marker','.','markersize',30);%电源开显示
text(-1,0.1,'ON');
Fun4=plot(-0.5,0.2,'color','r','marker','.','markersize',30);%电源关显示
text(-0.53,0.1,'OFF');
text(-0.9,0,'电源指示灯');
%停止按钮
pushbutton1=uicontrol(hf,...
    'units','normalized',...
    'style','pushbutton',...
    'string','停止',...
    'backgroundcolor',[0.75 0.75 0.75],...
    'position',[0.1 0.3 0.1 0.1],...
    'callback','k=0;');
%关闭按钮
pushbutton2=uicontrol(hf,...
    'units','normalized',...
    'style','pushbutton',...
    'string','关闭',...
    'backgroundcolor',[0.75 0.75 0.75],...
    'position',[0.3 0.3 0.1 0.1],...
    'callback','close');
temp=patch(x1,y1,[0 1 1]); %画室温初始温度
while k==1    %产生温度上升、下降动画
        set(Fun4,'color','k');
        set(Fun3,'color','r');
        if k1==1    %温度上升
            set(Fun1,'color','r');
            set(Fun2,'color','k');
            for i=1:1600
              a=t+(1-t)/1600*i;
              y1=[a -1 -1 a];
              set(temp,'ydata',y1);
              set(pp,'ydata',[a,a]);
              drawnow;
            end
            t=a;
            k1=0;
          else if k1==0     %温度下降
            set(Fun1,'color','k');
            set(Fun2,'color','r');
            for i=1:1000
                a=t-(t-0.2)/1000*i;
                y1=[a -1 -1 a];
                set(temp,'ydata',y1);
                set(pp,'ydata',[a,a]);
                drawnow;
            end
            t=a;
            k1=1;
              end
        end
end
set(Fun1,'color','k');  %停止还原
set(Fun2,'color','k');
    set(Fun3,'color','k');
    set(Fun4,'color','r');