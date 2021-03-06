
% 题目：既已琴瑟起，何以笙箫默
% 作者: 1304080023
%% 音乐播放部分
fs=48000; %音乐扫描频率
dt=1/fs; %播放速度
f0=320;%音乐调高
T16=0.4;%十六分音符时长
t16=0:dt:T16;
m=size(t16,2);
t1=linspace(0,16*T16,16*m);% 全音符时长
t4_3=linspace(0,12*T16,12*m);% 附点二分音符时长
t2=linspace(0,8*T16,8*m);% 二分音符时长
t8_3=linspace(0,6*T16,6*m);% 附点四分音符时长
t4=linspace(0,4*T16,4*m);% 四分音符时长
t16_3=linspace(0,3*T16,3*m);% 附点八分音符时长
t8=linspace(0,2*T16,2*m);% 八分音符时长
% 定义音阶强度

index={'1';'4_3';'2';'8_3';'4';'16_3';'8';'16'};% 音符   全音符 附点二分音符 二分音符 附点四分音符 四分音符 附点八分音符 八分音符 十六分音符
for n=1:8
    str=['mod',char(index(n)),' = sin(pi*t',char(index(n)),...
        '/t',char(index(n)),'(end));'];
    eval(str);
end
ScaleTable = [1/2 9/16 5/8 2/3 3/4 5/6 15/16 ...
    1 9/8 5/4 4/3 3/2 5/3 9/5 15/8 ...
    2 9/4 5/2 8/3 3 10/3 15/4 4];
txt={'do','re','mi','fa','so','la','xi'};% 音符数组do re mi fa so la xi
nstr={'0','1','2'};% 强度字符串，0为低音，1为正常音，2为高音
mstr={'o','T','t','F','f','E','e','s'}; % 音符字符串o T t F f E e s
for nn=1:8
    for jj=1:3
        for ii=1:7
            mm=7*(jj - 1) + ii;
            str=[char(txt(ii)),char(nstr(jj)),char(mstr(nn)),...
                ' = mod',char(index(nn)),...
                '.*cos(2*pi*ScaleTable(',num2str(mm),')*f0*t',...
                char(index(nn)),');'];
            eval(str);
        end
    end
end                          % 各分音符的数组

o = zeros(1,size(t1,2));% 字符o(one)，全音符
T = zeros(1,size(t4_3,2));% 字符T(Two)，附点二分音符
t = zeros(1,size(t2,2));% 字符t(two)，二分音符
F = zeros(1,size(t8_3,2));% 字符F(Four)，附点四分音符
f = zeros(1,size(t4,2));% 字符f(four)，四分音符
E = zeros(1,size(t16_3,2));% 字符E(Eight)，附点八分音符
e = zeros(1,size(t8,2));% 字符e(eight)，八分音符
s = zeros(1,size(t16,2));% 字符s(sixteen)，十六分音符
% 音符名称对应英文首字母，大写表示加附点

yuepu = [mi2f do2E re2s...
mi2e mi2E...
fa2f re2E mi2s...
fa2e fa2F...
so2f mi2E fa2s...
so2e so2f fa2e...
mi2t...
re2f so2f...
do2t...
so1t...
mi1f fa1f...
so1t...
fa1f re1e mi1e...
fa1f la1f...
so1t...
so1t...
do2F re2e...
mi2f do2e do2e...
so1f so1E fa1s...
mi1f so1f...
re1f re1e mi1e...
fa1f la1f...
la1t...
la1t...
so1f do2E re2s...
mi2t...
mi2f re2e do2e...
la1F la1e...
la1f fa2f...
fa2f mi2e re2e...
mi2t...
mi2t...
la1f la1f...
re2f re2E re2s...
mi2f fa2f...
so2f do2e do2e...
 re2f do2E do2s...
xi1f la1f...
so1t...
so1t...
so2f mi2E fa2s...
so2e so2F ...
fa2f re2E mi2s...
fa2e fa2f...
mi2f do2E re2s...
mi2e mi2e mi2e la1e...
la1f xi1e do2e...
mi2f re2E re2s...
re2e mi2e re2f...
re2t...
so2f mi2E fa2s...
so2e so2F...
fa2f re2E mi2s...
fa2e fa2f...
mi2f do2E re2s...
mi2e mi2e mi2e la1e...
la1f xi1e do2e...
mi2f re2E re2s...
re2e re2e so2f...
so2t...
so2e fa2e mi2f...
mi2f so2f...
re2f mi2F ...
mi2t...
do2t ...
do2t];% 音乐乐谱（yuepu数组内变量的命名规则：“音阶+强度+音符”形式）
%若有休止符号，直接写音符
yuepu = yuepu/max(yuepu);

%% 动画部分
figure('name','既已琴瑟起，何以笙箫默');% 设置标题名字
hold on;axis equal;% 建立坐标系
X=400;Y=200;% 动画部分长宽
axis([-1*X X -1*Y Y]);% 绘制长宽
axis off % 除掉Axes
a=0:0.01:2*pi;
r1=3;r2=3;% 音符参数
% 绘制音符1
x1=-340;y1=105;t1=0;dt1=0.18*10;a1=20;w1=-0.05;f1=0;% 横坐标、纵坐标、位移、速度、运动曲线幅值、频率、初相位
yinfu11=line(x1+[0 0],y1+[0 20],'color','black','linestyle','-','linewidth',2);
yinfu110=fill(x1-3+r1*cos(a),y1-2+r2*sin(a+pi/6),'black');
yinfu12=line(x1+[0 15],y1+[20 20],'color','black','linestyle','-','linewidth',2);
yinfu13=line(x1+[15 15],y1+[20 0],'color','black','linestyle','-','linewidth',2);
yinfu130=fill(x1+12+r1*cos(a),y1-2+r2*sin(a+pi/6),'black');
% 绘制音符2
x2=-290;y2=140;t2=0;dt2=0.2*10;a2=10;w2=0.04;f2=pi/6;% 横坐标、纵坐标、位移、速度、运动曲线幅值、频率、初相位
yinfu21=line(x2+[0;0],y2+[0;20],'color','black','linestyle','-','linewidth',2);
yinfu210=fill(x2-3+r1*cos(a),y2-2+r2*sin(a+pi/6),'black');
yinfu22=line(x2+[0 15],y2+[20 20],'color','black','linestyle','-','linewidth',2);
yinfu23=line(x2+[15 15],y2+[20 0],'color','black','linestyle','-','linewidth',2);
yinfu230=fill(x2+12+r1*cos(a),y2-2+r2*sin(a+pi/6),'black');
% 绘制音符3
x3=-230;y3=125;t3=0;dt3=0.21*10;a3=15;w3=0.07;f3=pi/2;% 横坐标、纵坐标、位移、速度、运动曲线幅值、频率、初相位
yinfu31=line(x3+[0 0],y3+[0 20],'color','black','linestyle','-','linewidth',2);
yinfu310=fill(x3-3+r1*cos(a),y3-2+r2*sin(a+pi/6),'black');
% 绘制音符4
x4=-160;y4=140;t4=0;dt4=0.22*10;a4=23;w4=0.065;f4=pi/1.5;% 横坐标、纵坐标、位移、速度、运动曲线幅值、频率、初相位
yinfu41=line(x4+[0;0],y4+[0;20],'color','black','linestyle','-','linewidth',2);
yinfu410=fill(x4-3+r1*cos(a),y4-2+r2*sin(a+pi/6),'black');
yinfu42=line(x4+[0 15],y4+[20 20],'color','black','linestyle','-','linewidth',2);
yinfu43=line(x4+[15 15],y4+[20 0],'color','black','linestyle','-','linewidth',2);
yinfu430=fill(x4+12+r1*cos(a),y4-2+r2*sin(a+pi/6),'black');
% 绘制音符5
x5=-50;y5=110;t5=0;dt5=0.23*10;a5=30;w5=0.068;f5=pi/6;% 横坐标、纵坐标、位移、速度、运动曲线幅值、频率、初相位
yinfu51=line(x5+[0 0],y5+[0 20],'color','black','linestyle','-','linewidth',2);
yinfu510=fill(x5-3+r1*cos(a),y5-2+r2*sin(a+pi/6),'black');
% 绘制音符6
x6=40;y6=100;t6=0;dt6=0.18*10;a6=20;w6=-0.05;f6=0;% 横坐标、纵坐标、位移、速度、运动曲线幅值、频率、初相位
yinfu61=line(x6+[0;0],y6+[0;20],'color','black','linestyle','-','linewidth',2);
yinfu610=fill(x6-3+r1*cos(a),y6-2+r2*sin(a+pi/6),'black');
yinfu62=line(x6+[0 15],y6+[20 20],'color','black','linestyle','-','linewidth',2);
yinfu63=line(x6+[15 15],y6+[20 0],'color','black','linestyle','-','linewidth',2);
yinfu630=fill(x6+12+r1*cos(a),y6-2+r2*sin(a+pi/6),'black');
% 绘制音符7
x7=150;y7=145;t7=0;dt7=0.2*10;a7=10;w7=0.04;f7=pi/6;% 横坐标、纵坐标、位移、速度、运动曲线幅值、频率、初相位
yinfu71=line(x7+[0;0],y7+[0;20],'color','black','linestyle','-','linewidth',2);
yinfu710=fill(x7-3+r1*cos(a),y7-2+r2*sin(a+pi/6),'black');
yinfu72=line(x7+[0 15],y7+[20 20],'color','black','linestyle','-','linewidth',2);
yinfu73=line(x7+[15 15],y7+[20 0],'color','black','linestyle','-','linewidth',2);
yinfu730=fill(x7+12+r1*cos(a),y7-2+r2*sin(a+pi/6),'black');
% 绘制音符8
x8=260;y8=120;t8=0;dt8=0.21*10;a8=15;w8=0.07;f8=pi/2;% 横坐标、纵坐标、位移、速度、运动曲线幅值、频率、初相位
yinfu81=line(x8+[0 0],y8+[0 20],'color','black','linestyle','-','linewidth',2);
yinfu810=fill(x8-3+r1*cos(a),y8-2+r2*sin(a+pi/6),'black');
% 绘制古琴
line([-82 100],[-22 -15],'color','black','linestyle','-','linewidth',2);% 绘制上琴腰线条
line([-91 -82],[-30 -22],'color','black','linestyle','-','linewidth',2);
line([-151 -91],[-30 -30],'color','black','linestyle','-','linewidth',2);
line([-162 -151],[-24 -30],'color','black','linestyle','-','linewidth',2);
line([-222 -162],[-29 -24],'color','black','linestyle','-','linewidth',2);
line(144+180*cos(-1*pi/1.73:0.001:(1*pi/1.73-pi)),159+180*sin(-1*pi/1.73:0.001:(1*pi/1.73-pi)),'color','black','linestyle','-','linewidth',2);% 绘制琴颈，琴肩
line([188 248],[-15 -15],'color','black','linestyle','-','linewidth',2);
line(248+5*cos(pi/40:0.001:pi/1.8),-20+5*sin(pi/40:0.001:pi/1.8),'color','black','linestyle','-','linewidth',2);
line(-41.9+300*cos((-pi/18):0.001:pi/18),-69+300*sin((-pi/18):0.001:pi/18),'color','black','linestyle','-','linewidth',2);
line(248+5*cos((2*pi-pi/1.8):0.001:(2*pi-pi/40)),-118+5*sin((2*pi-pi/1.8):0.001:(2*pi-pi/40)),'color','black','linestyle','-','linewidth',2);
line([188 248],[-123 -123],'color','black','linestyle','-','linewidth',2);
line(144+180*cos(pi/2.4:0.001:pi/1.73),-297+180*sin(pi/2.4:0.001:pi/1.73),'color','black','linestyle','-','linewidth',2);
line([-82 100],[-116 -122],'color','black','linestyle','-','linewidth',2);% 绘制下琴腰线条
line([-91 -82],[-109 -117],'color','black','linestyle','-','linewidth',2);
line([-151 -91],[-109 -109],'color','black','linestyle','-','linewidth',2);
line([-162 -151],[-115 -109],'color','black','linestyle','-','linewidth',2);
line([-222 -162],[-110 -115],'color','black','linestyle','-','linewidth',2);
line(-219+30*cos(pi/1.9:0.001:pi/1.1),-59+30*sin(pi/1.9:0.001:pi/1.1),'color','black','linestyle','-','linewidth',2);% 绘制冠角，焦尾
line(-219+30*cos((2*pi-1*pi/1.1):0.001:(2*pi-1*pi/1.9)),-81+30*sin((2*pi-1*pi/1.1):0.001:(2*pi-1*pi/1.9)),'color','black','linestyle','-','linewidth',2);
line(-248+20*cos(pi/0.66:0.001:pi/0.54),-31+20*sin(pi/0.66:0.001:pi/0.54),'color','black','linestyle','-','linewidth',2);
line(-248+20*cos((2*pi-pi/0.54):0.001:(2*pi-pi/0.66)),-110+20*sin((2*pi-pi/0.54):0.001:(2*pi-pi/0.66)),'color','black','linestyle','-','linewidth',2);
line(-231+20*cos(pi/0.66:0.001:pi/0.53),-21+20*sin(pi/0.66:0.001:pi/0.53),'color','black','linestyle','-','linewidth',2);
line(-231+20*cos((2*pi-pi/0.53):0.001:(2*pi-pi/0.66)),-120+20*sin((2*pi-pi/0.53):0.001:(2*pi-pi/0.66)),'color','black','linestyle','-','linewidth',2);
line(-116+130*cos(pi/1.05:0.001:(2*pi-pi/1.05)),-70+130*sin(pi/1.05:0.001:(2*pi-pi/1.05)),'color','black','linestyle','-','linewidth',2);
line(-112+130*cos(pi/1.053:0.001:(2*pi-pi/1.053)),-70+130*sin(pi/1.053:0.001:(2*pi-pi/1.053)),'color','black','linestyle','-','linewidth',2);
line([190 190],[-122 -15],'color','black','linestyle','-','linewidth',2);%绘制岳山（弦眼固定处的竖直线条）
line([200 200],[-122 -15],'color','black','linestyle','-','linewidth',2);
line([220 220],[-122 -15],'color','black','linestyle','-','linewidth',2);
p=0:0.001:2*pi;
fill(195+2*cos(p),-30+2*sin(p),'black');% 绘制弦眼
fill(195+2*cos(p),-43+2*sin(p),'black');
fill(195+2*cos(p),-56+2*sin(p),'black');
fill(195+2*cos(p),-69+2*sin(p),'black');
fill(195+2*cos(p),-82+2*sin(p),'black');
fill(195+2*cos(p),-95+2*sin(p),'black');
fill(195+2*cos(p),-108+2*sin(p),'black');
line(-200,-45,'color','black','linestyle','--','linewidth',2);% 绘制琴徽
line(-180,-44,'color','black','linestyle','--','linewidth',2);
line(-160,-43,'color','black','linestyle','--','linewidth',2);
line(-140,-42,'color','black','linestyle','--','linewidth',2);
line(-110,-40,'color','black','linestyle','--','linewidth',2);
line(-80,-38,'color','black','linestyle','--','linewidth',2);
line(-35,-35,'color','black','linestyle','--','linewidth',2);
line(10,-32.5,'color','black','linestyle','--','linewidth',2);
line(45,-31,'color','black','linestyle','--','linewidth',2);
line(85,-29,'color','black','linestyle','--','linewidth',2);
line(110,-28.5,'color','black','linestyle','--','linewidth',2);
line(127,-28,'color','black','linestyle','--','linewidth',2);
line(141,-27.7,'color','black','linestyle','--','linewidth',2);
% 绘制琴弦
control=0;con=10;choose=2;% 琴弦交替控制变量,交替周期
time=0;% 琴弦抖动快慢控制变量
T=886;% 琴弦长度
q=0:0.01:T/2;sign=1;
xian1=line([-245 198],[-55 -30.5],'color','black','linestyle','-','linewidth',2);% 一弦
xian2=line([-245 198],[-60 -43],'color','black','linestyle','-','linewidth',2);% 二弦
xian3=line([-245 198],[-65 -56],'color','black','linestyle','-','linewidth',2);% 三弦
xian4=line(-245+q,-69+1*sin(2*pi/T*q),'color','black','linestyle','-','linewidth',2);% 四弦
xian5=line([-245 198],[-73 -82],'color','black','linestyle','-','linewidth',2);% 五弦
xian6=line([-245 198],[-78 -95.5],'color','black','linestyle','-','linewidth',2);% 六弦
xian7=line([-245 198],[-83 -109],'color','black','linestyle','-','linewidth',2);% 七弦

sound(yuepu,fs);%调用函数播放音乐

while 1
    % 设置音符1运动
    t1=t1+dt1;
    x11=x1+t1;y11=y1+a1*sin(w1*t1+f1);
    set(yinfu11,'xdata',x11+[0 0],'ydata',y11+[0 20]);%设置运动过程
    set(yinfu110,'xdata',x11-3+r1*cos(a),'ydata',y11-2+r2*sin(a+pi/6));
    set(yinfu12,'xdata',x11+[0 15],'ydata',y11+[20 20]);
    set(yinfu13,'xdata',x11+[15 15],'ydata',y11+[20 0]);
    set(yinfu130,'xdata',x11+12+r1*cos(a),'ydata',y11-2+r2*sin(a+pi/6));
    if x11>=X
        t1=-1*X-x1;
    end
    % 设置音符2运动
    t2=t2+dt2;
    x22=x2+t2;y22=y2+a2*sin(w2*t2+f2);
    set(yinfu21,'xdata',x22+[0 0],'ydata',y22+[0 20]);%设置运动过程
    set(yinfu210,'xdata',x22-3+r1*cos(a),'ydata',y22-2+r2*sin(a+pi/6));
    set(yinfu22,'xdata',x22+[0 15],'ydata',y22+[20 20]);
    set(yinfu23,'xdata',x22+[15 15],'ydata',y22+[20 0]);
    set(yinfu230,'xdata',x22+12+r1*cos(a),'ydata',y22-2+r2*sin(a+pi/6));
    if x22>X
        t2=-1*X-x2;
    end
    % 设置音符3运动
    t3=t3+dt3;
    x33=x3+t3;y33=y3+a3*sin(w3*t3+f3);
    set(yinfu31,'xdata',x33+[0 0],'ydata',y33+[0 20]);%设置运动过程
    set(yinfu310,'xdata',x33-3+r1*cos(a),'ydata',y33-2+r2*sin(a+pi/6));
    if x33>X
        t3=-1*X-x3;
    end
    % 设置音符4运动
    t4=t4+dt4;
    x44=x4+t4;y44=y4+a4*sin(w4*t4+f4);
    set(yinfu41,'xdata',x44+[0 0],'ydata',y44+[0 20]);%设置运动过程
    set(yinfu410,'xdata',x44-3+r1*cos(a),'ydata',y44-2+r2*sin(a+pi/6));
    set(yinfu42,'xdata',x44+[0 15],'ydata',y44+[20 20]);
    set(yinfu43,'xdata',x44+[15 15],'ydata',y44+[20 0]);
    set(yinfu430,'xdata',x44+12+r1*cos(a),'ydata',y44-2+r2*sin(a+pi/6));
    if x44>X
        t4=-1*X-x4;
    end
    % 设置音符5运动
    t5=t5+dt5;
    x55=x5+t5;y55=y5+a5*sin(w5*t5+f5);
    set(yinfu51,'xdata',x55+[0 0],'ydata',y55+[0 20]);%设置运动过程
    set(yinfu510,'xdata',x55-3+r1*cos(a),'ydata',y55-2+r2*sin(a+pi/6));
    if x55>X
        t5=-1*X-x5;
    end
    % 设置音符6运动
    t6=t6+dt6;
    x66=x6+t6;y66=y6+a6*sin(w6*t6+f6);
    set(yinfu61,'xdata',x66+[0 0],'ydata',y66+[0 20]);%设置运动过程
    set(yinfu610,'xdata',x66-3+r1*cos(a),'ydata',y66-2+r2*sin(a+pi/6));
    set(yinfu62,'xdata',x66+[0 15],'ydata',y66+[20 20]);
    set(yinfu63,'xdata',x66+[15 15],'ydata',y66+[20 0]);
    set(yinfu630,'xdata',x66+12+r1*cos(a),'ydata',y66-2+r2*sin(a+pi/6));
    if x66>=X
        t6=-1*X-x6;
    end
    % 设置音符7运动
    t7=t7+dt7;
    x77=x7+t7;y77=y7+a7*sin(w7*t7+f7);
    set(yinfu71,'xdata',x77+[0 0],'ydata',y77+[0 20]);%设置运动过程
    set(yinfu710,'xdata',x77-3+r1*cos(a),'ydata',y77-2+r2*sin(a+pi/6));
    set(yinfu72,'xdata',x77+[0 15],'ydata',y77+[20 20]);
    set(yinfu73,'xdata',x77+[15 15],'ydata',y77+[20 0]);
    set(yinfu730,'xdata',x77+12+r1*cos(a),'ydata',y77-2+r2*sin(a+pi/6));
    if x77>X
        t7=-1*X-x7;
    end
    % 设置音符8运动
    t8=t8+dt8;
    x88=x8+t8;y88=y8+a8*sin(w8*t8+f8);
    set(yinfu81,'xdata',x88+[0 0],'ydata',y88+[0 20]);%设置运动过程
    set(yinfu810,'xdata',x88-3+r1*cos(a),'ydata',y88-2+r2*sin(a+pi/6));
    if x88>X
        t8=-1*X-x8;
    end
    %设置琴弦运动
    time=time+1;
    control=control+1;
    if control>con
        choose=round(rand(1,1)*6);
        control=0;
    end
    switch choose
        case 0
            set(xian1,'xdata',[-245 198],'ydata',[-55 -30.5+sign*0.5]);%第一根弦抖动
        case 1
            set(xian2,'xdata',[-245 198],'ydata',[-60 -43+sign*0.5]);%第二根弦抖动
        case 2
            set(xian3,'xdata',[-245 198],'ydata',[-65 -56+sign*0.5]);%第三根弦抖动
        case 3
            set(xian4,'xdata',-245+q,'ydata',-69+sign*1*sin(2*pi/T*q));%第四根弦抖动
        case 4
            set(xian5,'xdata',[-245 198],'ydata',[-73 -82+sign*0.5]);%第五根弦抖动
        case 5
            set(xian6,'xdata',[-245 198],'ydata',[-78 -95.5+sign*0.5]);%第六根弦抖动
        case 6
            set(xian7,'xdata',[-245 198],'ydata',[-83 -109+sign*0.5]);%第七根弦抖动
    end
    sign=-1*sign;
    time=0;
    if control==7*con
        control=0;
    end
    drawnow;
end
