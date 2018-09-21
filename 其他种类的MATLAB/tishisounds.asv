% 有时候我们需要用matlab发出提示音，怎么办呢？

%可以用matlab函数sound实现。该函数的输入参量是音频数据向量、采样频率和转换位数。

%我们可以自己写些声音数据。下面的声音声调和频率有关，长度和数据长度有关：
sound(sin(2*pi*25*(1:4000)/100));
pause(1);
sound(sin(2*pi*25*(1:4000)/100));%响两声
load chirp%鸟声
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
%播放声音，wavread进来一段音频再wavplay，或者sound函数，都是播放声音用的。wav组合多用于wav格式音频。