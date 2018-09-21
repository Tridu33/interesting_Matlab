function varargout = dafei20140819(varargin)
%按键说明：
%W、向上箭头、小键盘5：变换形状；
%A、向左箭头、小键盘1：左移；
%S、向下箭头、小键盘2：快速下移；
%D、向右箭头、小键盘3：右移；
%空格键：暂停。
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dafei20140819_OpeningFcn, ...
                   'gui_OutputFcn',  @dafei20140819_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function dafei20140819_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
global shapes px py shape_colors nt1 nt nn2 fenshu player_npwz player_ffy mode nn np cg_flag pach  tt
tt=0;
[npwz,Fs1] = audioread('南屏晚钟.mp3');
[ffy,Fs2] = audioread('分飞燕.mp3');
player_npwz = audioplayer(npwz, Fs1);
player_ffy = audioplayer(ffy, Fs2);
mode = true;
player_npwz.StopFcn = 'global mode player_ffy, if mode,play(player_ffy);end';
player_ffy.StopFcn = 'global mode player_npwz, if mode,play(player_npwz);end';

try
    load('fenshu');
catch
    a1=0;
    a2=0;
    a3=0;
    save('fenshu','a1','a2','a3');
end
str1=sprintf('第一名：%6.0f',a1);
str2=sprintf('第二名：%6.0f',a2);
str3=sprintf('第三名：%6.0f',a3);
set(handles.fen_shu,'string',{str1;str2;str3})
pach=zeros(1,4);
cg_flag=0;%闯关模式标志
nn=3000;%每3000次定时计数后增加两行
nn2=0;
np=7;%图形样式种数的选择
nt1=0;
nt=16;%下移控制
fenshu=0;  %分数值
line('parent',handles.axes1,'xdata',[0,10,10,0,0],'ydata',[0,0,18,18,0])%方框
shapes=zeros(2,5,20,4);
shapes(:,:,:,1) = reshape([-1  0  0 0 0  1  1  0 0  0   -1  0  0  0  1  0  2  0  0  0   ...
                            0  2  0 1 0  0  1  0 0  0   -1  0  0  0  0  1  1  1  0  0   ...
                            1  1  0 1 0  0  1  0 0  0    0  1  0  0  0 -1 -1 -1  0  0   ...
                           -1  1  0 1 0  0  1  0 0  0    0  1  0  0  0 -1  0  0  0  0   ...
                            0  1  0 0 -1 0  0  0 0  0   -1  1  0  1  0  0  0 -1  1 -1   ...
                            0  1  0 0 0  0  0  0 0  0   -1  1  0  1  0  0  1  0  1  1   ...
                            0  2  0 1 0  0 -1  0 1  0    0  0  0  0  0  0  0  0  0  0   ...
                           -1  1 -1 0 0  0  1  0 1  1   -1  0  0  0  1  0  0  1  0 -1   ...
                            -1 1  0 1 0  0  1  0 2  0   0  2  0  1  0  0  0 -1 -1 -1   ...
                            0  2  0 1 0  0  0 -1 -1 0   0  2  0  1  0  0  1  0  2  0 ],2,5,20);
  %shapes采用一个坐标点来表示一个方块（patch），每5个方块构成一个图形。
  %设某个图形的5个方块右上角坐标分别为：(x1,y1),(x2,y2),(x3,y3),(x4,y4),(x5,y5)。
  %则shapes(:,:,1)=reshape([x1 y1 x2 y2 x3 y3 x4 y4 x5 y5],2,5,1)
  %共有20种图形
for i=1:20   %20种图形中每种图形有3种变换图形
    shapes(:,:,i,2) = [0,1;-1,0]*shapes(:,:,i,1);
    shapes(:,:,i,3) = [0,1;-1,0]*shapes(:,:,i,2);
    shapes(:,:,i,4) = [0,1;-1,0]*shapes(:,:,i,3);
end
shapes(:,:,5,4)=shapes(:,:,5,1);%田字型为特例
shapes(:,:,5,3)=shapes(:,:,5,1);
shapes(:,:,5,2)=shapes(:,:,5,1);
shape_colors = [1 0 0;0.502 0 0;1 1 0;0.502 0.502 0;0 1 0;...
    0.502 0 0.251;0 0 1;0.251 0.502 0.502;0.502 0.502 0.502;0.251 0 0;...
    0.502 0.502 0;0 0.502 0;0.251 0 0.502;0 0 0.251;0.502 0 1;...
    0 0.502 0.7529;0.502 1 0.502;1 0.502 0.251;0 0.502 0.7529;0.502 0.502 0.7529];  %每种图形的颜色
px = [0;-1;-1;0];  %patch初始位置					
py = [0;0;-1;-1];  %patch初始位置
set(handles.look,'label','是男人就得5万分！')

play(player_npwz);

tic;
guidata(hObject, handles);

function p_t(obj,event,handles)
if ~ishandle(handles.figure1)
    return;
end
global shapes px py p_sel pos pach shape_colors map p_n map_x nt1 nt nn tt
global map_y pos4 fenshu p_run nn2 
global p_n2 pos42 p_sel2 p_sel_color2 np cg_flag show_flag
if ~p_run
    return;
end
nn2=nn2+1;
tt=tt+1;
if tt>=50
    tt=0;
    if nn2>nn
        nn2=nn;
    end
    str=sprintf('%2.0f秒',floor((nn-nn2)*0.02));
    set(handles.next_two,'string',{'离下次增加两行还剩：';str})
end
nt1=nt1+1;
if cg_flag
    if fenshu<10000
        if show_flag
            show_flag=0;
            set(handles.level_n,'string','第1关','visible','on')
            set(handles.guanshu,'string','当前关数：1/5')
            nn=6000;%每6000次定时计数后增加两行
            np=7;%图形样式种数的选择
            nt=16;%下移
            pause(1);
            set(handles.level_n,'visible','off')
        end
    elseif fenshu<20000
        if ~show_flag
            show_flag=1;
            set(handles.level_n,'string','第2关','visible','on')
            set(handles.guanshu,'string','当前关数：2/5')
            nn=5000;%每5000次定时计数后增加两行
            np=10;%图形样式种数的选择
            nt=12;%下移
            pause(1);
            set(handles.level_n,'visible','off')
        end
    elseif fenshu<30000
        if show_flag
            show_flag=0;
            set(handles.level_n,'string','第3关','visible','on')
            set(handles.guanshu,'string','当前关数：3/5')
            nn=4000;%每4000次定时计数后增加两行
            np=13;%图形样式种数的选择
            nt=10;%下移
            pause(1);
            set(handles.level_n,'visible','off')
        end
    elseif fenshu<40000
        if ~show_flag
            show_flag=1;
            set(handles.level_n,'string','第4关','visible','on')
            set(handles.guanshu,'string','当前关数：4/5')
            nn=3000;%每3000次定时计数后增加两行
            np=13;%图形样式种数的选择
            nt=8;%下移
            pause(1);
            set(handles.level_n,'visible','off')
        end
    elseif fenshu<50000
        if show_flag
            show_flag=0;
            set(handles.level_n,'string','第5关','visible','on')
            set(handles.guanshu,'string','当前关数：5/5')
            nn=2500;%每2500次定时计数后增加两行
            np=20;%图形样式种数的选择
            nt=6;%下移
            pause(1);
            set(handles.level_n,'visible','off')
        end
    else
        if show_flag
            show_flag=0;
            set(handles.level_n,'string','恭喜通关','visible','on')
            set(handles.guanshu,'string','已通关')
            pause(1);
            set(handles.level_n,'visible','off')
        end
    end
end
cmd=get(handles.figure1,'currentkey');
if strcmp(cmd,'s') || strcmp(cmd,'downarrow') || strcmp(cmd,'numpad2')
    if toc<0.2
        nt=1;
    end
else
    if nt==1
        if strcmp(get(handles.beginner,'checked'),'on')
            nt=16;
        elseif strcmp(get(handles.intermediate,'checked'),'on')
            nt=10;
        else
            nt=4;
        end
    end
end
if nt1<nt
    return;
else
    nt1=0;
end
pos_temp = pos + [0;-1];
map_y1 = map_y;
map_x1 = map_x - 1;
if ~min(map_x1) || map(map_x1(1),map_y1(1)) || map(map_x1(2),map_y1(2)) || ...
        map(map_x1(3),map_y1(3)) || map(map_x1(4),map_y1(4)) || map(map_x1(5),map_y1(5))%如果到底部或停止下降
    if max(map_x1)>=16   %GAME OVER!
        h=findobj(handles.axes1,'type','patch');
        delete(h);
        clear h
        text(0.5,10,'GAME OVER!','parent',handles.axes1,'Color','r','fontsize',30,'fontname','华文行楷');
        pach=zeros(1,5);
        stop(obj);
        delete(obj);
        clear obj
        load('fenshu');
        temp=sort([a1 a2 a3 fenshu],'descend');
        a1=temp(1);
        a2=temp(2);
        a3=temp(3);
        str1=sprintf('第一名：%6.0f',a1);
        str2=sprintf('第二名：%6.0f',a2);
        str3=sprintf('第三名：%6.0f',a3);
        save('fenshu','a1','a2','a3');
        set(handles.fen_shu,'string',{str1;str2;str3})
        return;
    end
    for i = 1:5
        map(map_x(i),map_y(i))=1;
    end
    n=find(all(map,2));     %计分；找出映射矩阵中元素全为1的行
    if ~isempty(n)
        n=sort(n,'descend');
        for k=1:length(n)
            map(n(k):end-1,:)=map(n(k)+1:end,:);
            map(end,:)=0;
        end
        if length(n)==1
            fenshu=fenshu+100;
        else
            fenshu=fenshu+100*2^length(n);%计算分数
        end
        set(handles.fenshu,'string',sprintf('分数：%6.0f',fenshu))%显示分数
        a=findobj(handles.axes1,'type','patch');
        b=get(a,'ydata');
        c=cell2mat(b');
        for i=1:length(n)   %消行%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
            line('parent',handles.axes1,'xdata',[0,10,10,0,0],'ydata',[n(i)-1,n(i)-1,n(i),n(i),n(i)-1],...
                 'LineWidth',2.1,'Color','r')%方框
        end
        pause(0.2);
        for i=1:length(n)   %消行%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
            delete(a(find(c(1,:)==n(i))));
        end
        delete(findobj(handles.axes1,'type','line','LineWidth',2.1));
        for i=1:length(n)
            c2=a(find(c(1,:)>n(i)));
            if ~isempty(c2)
                for j=1:length(c2)
                    if ishandle(c2(j))
                        c3=get(c2(j),'ydata');
                        set(c2(j),'ydata',c3-1)
                    end
                end
            end
        end
    end
    drawnow;
    if nn2>=nn
        nn2=0;
        n1=find(any(map,2)==1);
        h=findobj(handles.axes1,'type','patch');
        if max(n1)>=14
            delete(h);
            clear h
            text(0.5,10,'GAME OVER!','parent',handles.axes1,'Color','r','fontsize',30,'fontname','华文行楷');
            load('fenshu');
            temp=sort([a1 a2 a3 fenshu],'descend');
            a1=temp(1);
            a2=temp(2);
            a3=temp(3);
            str1=sprintf('第一名：%6.0f',a1);
            str2=sprintf('第二名：%6.0f',a2);
            str3=sprintf('第三名：%6.0f',a3);
            save('fenshu','a1','a2','a3');
            set(handles.fen_shu,'string',{str1;str2;str3})
            pach=zeros(1,5);
            return;
        else
            map2=randi([0 1],2,10);
            map(3:end,:)=map(1:end-2,:);
            map(1:2,:)=map2;
            if ~isempty(h)
                for kk=1:length(h)
                	set(h(kk),'ydata',get(h(kk),'ydata')+2)
                end
            end
            drawnow;
            for ix=1:2
                for iy=1:10
                    if map2(ix,iy)
                        patch(px + iy,py+ix,[1 0 0],'parent',handles.axes1);
                    end
                end
            end
            drawnow;
        end
    end
    p_n = p_n2;
    pos4 = pos42;
    p_sel = p_sel2;   %随机获取patch
    p_sel_color = p_sel_color2;%随机获取颜色
    pos = [5;16];   %初始化图形初始位置
    p_n2=randi([1,np]); 
    pos42=randi([1,4]); 
    p_sel2=shapes(:,:,p_n2,pos42);  
    p_sel_color2=shape_colors(p_n2,:);
    delete(findobj(handles.axes2,'type','patch'));
    pach=zeros(1,5);
    for i = 1:5     %更新映射矩阵map，并产生一个新的图形
        pach(i) = patch(px + pos(1) + p_sel(1,i),...
            py + pos(2) + p_sel(2,i),p_sel_color,'parent',handles.axes1);
        patch(px + p_sel2(1,i),py + p_sel2(2,i),p_sel_color2,'parent',handles.axes2);
    end
    map_y = p_sel(1,:) + pos(1);%新产生的图形位置的映射
    map_x = p_sel(2,:) + pos(2);%新产生的图形位置的映射
    pause(0.02);
    drawnow;
else
    if nt==1
        if strcmp(get(handles.beginner,'checked'),'on')
            nt=16;
        elseif strcmp(get(handles.intermediate,'checked'),'on')
            nt=10;
        else
            nt=4;
        end
    end
    pos = pos_temp;
    map_x = map_x1;
    map_y = map_y1;
    for i = 1:5
        set(pach(i),'XData',px+pos(1) + p_sel(1,i),'YData',py+pos(2) + p_sel(2,i),'parent',handles.axes1);
    end
    drawnow;
end

function varargout = dafei20140819_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function figure1_KeyPressFcn(hObject, eventdata, handles)
global shapes px py p_sel pos pach shape_colors map p_n map_x nn nn2
global map_y pos4 fenshu p_run 
cmd=get(hObject,'currentkey');
if strcmp(cmd,'f5')
    restart_Callback(hObject, eventdata, handles);
    return;
end
if ~all(pach)
    return;
end
x_pos=cell2mat(get(pach,'xdata'));
switch cmd
    case {'a','leftarrow','numpad1'}     %左移
        p_run=0;
        pos_temp = pos + [-1;0];
        map_y1 = map_y - 1;
        map_x1 = map_x;
        if min(x_pos)>0 && (~map(map_x1(1),map_y1(1))) &&...
                (~map(map_x1(2),map_y1(2))) && (~map(map_x1(3),map_y1(3))) && ...
                (~map(map_x1(4),map_y1(4))) && (~map(map_x1(5),map_y1(5)))
            pos=pos_temp;
            map_y = map_y1;
            map_x = map_x1;
            for i = 1:5
                set(pach(i),'XData',px+pos(1) + p_sel(1,i),'YData',py+pos(2) + p_sel(2,i));
            end
        end
        p_run=1;
    case {'d','rightarrow','numpad3'}    %右移
        p_run=0;
        pos_temp = pos + [1;0];
        map_y1 = map_y + 1;
        map_x1 = map_x;
        if max(x_pos)<10 && (~map(map_x1(1),map_y1(1))) && (~map(map_x1(2),map_y1(2))) && ...
                (~map(map_x1(3),map_y1(3))) && (~map(map_x1(4),map_y1(4))) &&(~map(map_x1(5),map_y1(5)))
            pos = pos_temp;
            map_y = map_y1;
            map_x = map_x1;
            for i = 1:5
                set(pach(i),'XData',px+pos(1) + p_sel(1,i),'YData',py+pos(2) + p_sel(2,i));
            end
        end
        p_run=1;
    case {'s','downarrow','numpad2'}
        tic;
    case {'w','uparrow','numpad5'}   %变换
        pos4_temp=pos4;
        if pos4_temp==4
            pos4_temp=1;
        else
            pos4_temp=pos4_temp+1;
        end
        psel_temp=shapes(:,:,p_n,pos4_temp);   
        mapy_temp = psel_temp(1,:) + pos(1);
        mapx_temp = psel_temp(2,:) + pos(2);
        a=zeros(5,4);
        for i = 1:5
            a(i,:)=px + pos(1) + psel_temp(1,i);
        end
        if min(min(a))>=0 && max(max(a))<=10 && all(mapx_temp) && all(mapy_temp) && ...
                (~map(mapx_temp(1),mapy_temp(1))) && ...
                (~map(mapx_temp(2),mapy_temp(2))) && (~map(mapx_temp(3),mapy_temp(3))) &&...
                (~map(mapx_temp(4),mapy_temp(4))) && (~map(mapx_temp(5),mapy_temp(5))) 
            pos4 = pos4_temp;
            p_sel = psel_temp;
            map_y = mapy_temp;
            map_x = mapx_temp;
            for i = 1:5
                set(pach(i),'XData',a(i,:),'YData',py+pos(2) + p_sel(2,i));
            end
        end
    case 'space'      %暂停
        p_run=~p_run;
end

function caidan_Callback(hObject, eventdata, handles)

function help_Callback(hObject, eventdata, handles)

function method_Callback(hObject, eventdata, handles)
message={'按键说明:';'W、向上箭头、小键盘5：变换形状；';'A、向左箭头、小键盘1：左移；';...
'S、向下箭头、小键盘2：快速下移；';'D、向右箭头、小键盘3：右移；';'空格键：暂停。'};
msgbox(message,'游戏玩法','none');

function about_Callback(hObject, eventdata, handles)
msgbox({'版本：V3.0';'BY 罗华飞';'2014.8.19'},'关于.','none');

function restart_Callback(hObject, eventdata, handles)
global shapes px py p_sel p_sel_color pos pach shape_colors p_run map p_n map_x map_y pos4 fenshu np
global p_n2 pos42 p_sel2 p_sel_color2 nn2 nt1
nn2=0;
nt1=0;
p_run=0;
t=timerfind;
if ~isempty(t)
    stop(t);
    delete(t);
    clear t
end
try
    delete(findobj(handles.axes1,'type','patch','-or','type','text'));
end
set(handles.level_n,'visible','off')
fenshu=0;
pos=[5;16];
set(handles.fenshu,'string','分数：0')
map=zeros(18,10);     %映射矩阵
%将每个方块的位置映射到一个10*18的矩阵中，若矩阵某个元素为1，对应该位置存在方块
%用于判断消行和图形是否到达底部
p_n=randi([1,np]);
pos4=randi([1,4]);
p_sel=shapes(:,:,p_n,pos4);   %随机获取patch
p_sel_color=shape_colors(p_n,:);
map_y = p_sel(1,:) + pos(1);
map_x = p_sel(2,:) + pos(2);
p_n2=randi([1,np]); 
pos42=randi([1,4]); 
p_sel2=shapes(:,:,p_n2,pos42);  
p_sel_color2=shape_colors(p_n2,:);
delete(findobj(handles.axes2,'type','patch'));
pach=zeros(1,5);
for i = 1:5
    pach(i) = patch(px + pos(1) + p_sel(1,i),py + pos(2) + p_sel(2,i),p_sel_color,'parent',handles.axes1);
    patch(px + p_sel2(1,i),py + p_sel2(2,i),p_sel_color2,'parent',handles.axes2);
end
t=timer('BusyMode','queue','ExecutionMode','fixedSpacing',...
    'Period',0.02,'TimerFcn',{@p_t,handles});
p_run=1;
start(t);

function stop_game_Callback(hObject, eventdata, handles)
global p_run fenshu pach
p_run=0;
t=timerfind;
stop(t);
delete(findobj(handles.axes1,'type','patch'));
text(0.5,10,'GAME OVER!','parent',handles.axes1,'Color','r','fontsize',30,'fontname','华文行楷');
load('fenshu');
temp=sort([a1 a2 a3 fenshu],'descend');
a1=temp(1);
a2=temp(2);
a3=temp(3);
str1=sprintf('第一名：%6.0f',a1);
str2=sprintf('第二名：%6.0f',a2);
str3=sprintf('第三名：%6.0f',a3);
save('fenshu','a1','a2','a3');
set(handles.fen_shu,'string',{str1;str2;str3})
pach=zeros(1,5);

function beginner_Callback(hObject, eventdata, handles)
global nt nn np
set(handles.fenshu,'string','分数：0')
set(handles.beginner,'checked','on')
set(handles.intermediate,'checked','off')
set(handles.expert,'checked','off')
nt=16;
np=7;
nn=3000;

function intermediate_Callback(hObject, eventdata, handles)
global nt nn np
set(handles.fenshu,'string','分数：0')
set(handles.beginner,'checked','off')
set(handles.intermediate,'checked','on')
set(handles.expert,'checked','off')
nt=10;
np=14;
nn=2500;

function expert_Callback(hObject, eventdata, handles)
global nt nn np
set(handles.fenshu,'string','分数：0')
set(handles.beginner,'checked','off')
set(handles.intermediate,'checked','off')
set(handles.expert,'checked','on')
nt=4;
np=20;
nn=2000;

function sound_Callback(hObject, eventdata, handles)

function look_Callback(hObject, eventdata, handles)

function comm_Callback(hObject, eventdata, handles)

function chuangguan_Callback(hObject, eventdata, handles)
global fenshu p_run nn np cg_flag show_flag
cg_flag=~cg_flag;
if cg_flag
    p_run=0;
    t=timerfind;
    if ~isempty(t)
        stop(t);
        delete(t);
        clear t
    end
    try
        delete(findobj(handles.axes1,'type','patch','-or','type','text'));
        delete(findobj(handles.axes2,'type','patch'));
    end
    fenshu=0;
    set(handles.fenshu,'string','分数：0')
    set(handles.level_n,'visible','on','string','闯关模式')
    set(hObject,'checked','on')
    set(handles.comm,'enable','off')
    set(handles.guanshu,'string','当前关数：1/5','visible','on')
    show_flag=1;
    p_run=1;
else
    set(handles.level_n,'visible','off')
    set(hObject,'checked','off')
    set(handles.comm,'enable','on')
    set(handles.guanshu,'visible','off')
    show_flag=0;
end

function no_music_Callback(hObject, eventdata, handles)
global mode player_npwz player_ffy
set(hObject,'checked','on')
set([handles.npwz,handles.ffy],'checked','off');
mode = false;
stop(player_npwz);
stop(player_ffy);

function npwz_Callback(hObject, eventdata, handles)
global mode player_npwz player_ffy
set(hObject,'checked','on')
set(handles.ffy,'checked','off');
mode = false;
stop(player_npwz);
stop(player_ffy);
mode = true;
play(player_npwz);

function ffy_Callback(hObject, eventdata, handles)
global mode player_npwz player_ffy
set(hObject,'checked','on')
set(handles.npwz,'checked','off');
mode = false;
stop(player_npwz);
stop(player_ffy);
mode = true;
play(player_ffy);

function figure1_CloseRequestFcn(hObject, eventdata, handles)
t=timerfind;
if ~isempty(t)
    stop(t);
    delete(t);
    clear t
end
global fenshu p_run
if p_run
    load('fenshu');
    temp=sort([a1 a2 a3 fenshu],'descend');
    a1 = temp(1);
    a2 = temp(2);
    a3 = temp(3);
    save('fenshu', 'a1', 'a2', 'a3');
end
global mode player_npwz player_ffy
mode = false;
stop(player_npwz);
stop(player_ffy);
clear global
delete(hObject);

function sel_music_Callback(hObject, eventdata, handles)
[FileName,PathName,FilterIndex] = uigetfile('*.mp3','选择音乐文件');
if FilterIndex == 1
    global mode player3 player_npwz player_ffy
    mode = false;
    stop(player_npwz);
    stop(player_ffy);
    str = [PathName FileName];
    [y,Fs] = audioread(str);
    player3 = audioplayer(y, Fs);
    player3.StopFcn = 'global mode player3, if mode,play(player3);end';
    
    mode = true;
    play(player3);
end


