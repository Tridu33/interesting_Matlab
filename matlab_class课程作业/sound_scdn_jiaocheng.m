    fs=44100; %确定采样频率
    t=0: 1/fs: 0.5; %t为音长
    c=sin(2*pi*261.63 *t); %中央c的频率为261.63Hz
     sound(c, fs)
    %一个音阶大调音阶
    t=0: 1/fs: 0.5;
    do=sin(2*pi*261.63 *t); 
    re=sin(2*pi*293.66 *t); 
    mi=sin(2*pi*329.63 *t); 
    fa=sin(2*pi*349.23 *t); 
    so=sin(2*pi*392.00 *t); 
    la=sin(2*pi*440.00 *t); 
    ti=sin(2*pi*493.88 *t); 
    Cscale=[do,re,mi,fa,so,la,ti];
    sound(Cscale,fs)
    %Matlab自带的声音效果
        %鸟声
    load chirp
    sound(y,Fs)
    %锣声
    load gong
    sound(y,Fs)
    %哈里路亚
    load handel
    sound(y,Fs)
    %笑声
    load laughter
    sound(y,Fs)
    %啪哒声
    load splat
    sound(y,Fs)
    %火车
    load train
    sound(y,Fs)
    %上面介绍了如何用sound()来编辑单音与音阶。
%     但是玩音乐又怎么能没有和弦？
%     由于输入信号Y只能是一个N×2N×2的矩阵，
%     也就是说sound()一次最多可以同时播放两个音。
%     那么我们怎么实现最简单的大三和弦呢？
%     简单来说就是通过叠加。
        fs=44100;
    t=0: 1/fs: 0.5;
    y = sin(2*pi*261.63*t);
    y = y + sin(2*pi*329.63*t);
    y = y + sin(2*pi*392*t);
    soundsc(y,fs);   %soundsc()没有限制音量
    %再来一个大小七和弦(或者叫属七和弦)
       fs=44100;
    t=0: 1/fs: 0.5;
    y = sin(2*pi*261.63*t);
    y = y + sin(2*pi*329.63*t);
    y = y + sin(2*pi*466.16*t);
    soundsc(y,fs);   
    
    
   %实例 
     clear
    fs=44100;
    t=0: 1/fs: 0.5;

    %%%%%backing track%%%%%
    one=0.5*sin(2*pi*261.63*t);
    one=one+0.5*sin(2*pi*329.63*t);
    one=one+0.5*sin(2*pi*466.16*t);
    four=0.5*sin(2*pi*349.23*t);
    four=four+0.5*sin(2*pi*440*t);
    four=four+0.5*sin(2*pi*622.25*t);
    five=0.5*sin(2*pi*392*t);
    five=five+0.5*sin(2*pi*493.88*t);
    five=five+0.5*sin(2*pi*698.46*t);
    bar1=[one one one one];
    bar4=[four four four four];
    bar5=[five five five five];
    backing=[bar1 bar1 bar1 bar1 bar4 bar4 bar1 bar1    bar5 bar4 bar1 bar1];

    %%%%%pentatonic%%%%%
    so=sin(2*pi*196*t);
    la=sin(2*pi*220*t);
    do=sin(2*pi*261.63*t);
    re=sin(2*pi*293.66*t);
    blue=sin(2*pi*311.13*t);
    blk=sin(2*pi*0*t); %blank 

    %%%%%melody%%%%%
    melody=[so so la la do do blue blue blue blk re do do do la blue blue la ...
    la do blue re so la do blk blk re blue do re so la la so la do re blue ...
    blue blue so so la la re blue do];

    %%%%%%%%%%%%%%%
    song=[backing;melody];
    soundsc(song,fs)
    %最后，如果大家希望保存下来自己写的音频的话可以用audiowrite()函数。而读取则可用audioread()函数。

    audiowrite('mysong.wav',melody,fs)
    [y,Fs] = audioread('mysong.wav');
    %这个audioread()函数也十分有趣。我们可以录制一段自己的声音看看自己声音的函数图形。

    [y,Fs] = audioread('01.mp3');
    t=length(y);
    t=linspace(0, 1.8097,t); %时长可从audioinfo('test.m4a') 查看。
    plot(t,y)
    