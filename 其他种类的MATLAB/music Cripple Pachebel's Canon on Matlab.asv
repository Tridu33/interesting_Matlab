sp=actxserver('SAPI.SpVoice');
sp.Speak('我是会唱卡农的MATLAB')
pause(1);

%matlabspeech(txt,voice,pace,fs)打字直接出语音
% Cripple Pachebel's Canon on Matlab卡农
% Have fun
fs = 44100; % sample rate
dt = 1/fs;
T16 = 0.125;
t16 = [0:dt:T16];
[temp k] = size(t16);
t4 = linspace(0,4*T16,4*k);
t8 = linspace(0,2*T16,2*k);
[temp i] = size(t4);
[temp j] = size(t8);
% Modification functions
mod4 = sin(pi*t4/t4(end));
mod8 = sin(pi*t8/t8(end));
mod16 = sin(pi*t16/t16(end));
f0 = 2*146.8; % reference frequency
ScaleTable = [2/3 3/4 5/6 15/16 ...
1 9/8 5/4 4/3 3/2 5/3 9/5 15/8 ...
2 9/4 5/2 8/3 3 10/3 15/4 4 ...
1/2 9/16 5/8];
% 1/4 notes
do0f = mod4.*cos(2*pi*ScaleTable(21)*f0*t4);
re0f = mod4.*cos(2*pi*ScaleTable(22)*f0*t4);
mi0f = mod4.*cos(2*pi*ScaleTable(23)*f0*t4);
fa0f = mod4.*cos(2*pi*ScaleTable(1)*f0*t4);
so0f = mod4.*cos(2*pi*ScaleTable(2)*f0*t4);
la0f = mod4.*cos(2*pi*ScaleTable(3)*f0*t4);
ti0f = mod4.*cos(2*pi*ScaleTable(4)*f0*t4);
do1f = mod4.*cos(2*pi*ScaleTable(5)*f0*t4);
re1f = mod4.*cos(2*pi*ScaleTable(6)*f0*t4);
mi1f = mod4.*cos(2*pi*ScaleTable(7)*f0*t4);
fa1f = mod4.*cos(2*pi*ScaleTable(8)*f0*t4);
so1f = mod4.*cos(2*pi*ScaleTable(9)*f0*t4);
la1f = mod4.*cos(2*pi*ScaleTable(10)*f0*t4);
tb1f = mod4.*cos(2*pi*ScaleTable(11)*f0*t4);
ti1f = mod4.*cos(2*pi*ScaleTable(12)*f0*t4);
do2f = mod4.*cos(2*pi*ScaleTable(13)*f0*t4);
re2f = mod4.*cos(2*pi*ScaleTable(14)*f0*t4);
mi2f = mod4.*cos(2*pi*ScaleTable(15)*f0*t4);
fa2f = mod4.*cos(2*pi*ScaleTable(16)*f0*t4);
so2f = mod4.*cos(2*pi*ScaleTable(17)*f0*t4);
la2f = mod4.*cos(2*pi*ScaleTable(18)*f0*t4);
ti2f = mod4.*cos(2*pi*ScaleTable(19)*f0*t4);
do3f = mod4.*cos(2*pi*ScaleTable(20)*f0*t4);
blkf = zeros(1,i);
% 1/8 notes
fa0e = mod8.*cos(2*pi*ScaleTable(1)*f0*t8);
so0e = mod8.*cos(2*pi*ScaleTable(2)*f0*t8);
la0e = mod8.*cos(2*pi*ScaleTable(3)*f0*t8);
ti0e = mod8.*cos(2*pi*ScaleTable(4)*f0*t8);
do1e = mod8.*cos(2*pi*ScaleTable(5)*f0*t8);
re1e = mod8.*cos(2*pi*ScaleTable(6)*f0*t8);
mi1e = mod8.*cos(2*pi*ScaleTable(7)*f0*t8);
fa1e = mod8.*cos(2*pi*ScaleTable(8)*f0*t8);
so1e = mod8.*cos(2*pi*ScaleTable(9)*f0*t8);
la1e = mod8.*cos(2*pi*ScaleTable(10)*f0*t8);
tb1e = mod8.*cos(2*pi*ScaleTable(11)*f0*t8);
ti1e = mod8.*cos(2*pi*ScaleTable(12)*f0*t8);
do2e = mod8.*cos(2*pi*ScaleTable(13)*f0*t8);
re2e = mod8.*cos(2*pi*ScaleTable(14)*f0*t8);
mi2e = mod8.*cos(2*pi*ScaleTable(15)*f0*t8);
fa2e = mod8.*cos(2*pi*ScaleTable(16)*f0*t8);
so2e = mod8.*cos(2*pi*ScaleTable(17)*f0*t8);
la2e = mod8.*cos(2*pi*ScaleTable(18)*f0*t8);
ti2e = mod8.*cos(2*pi*ScaleTable(19)*f0*t8);
do3e = mod8.*cos(2*pi*ScaleTable(20)*f0*t8);
blke = zeros(1,j);
% 1/16 notes
fa0s = mod16.*cos(2*pi*ScaleTable(1)*f0*t16);
so0s = mod16.*cos(2*pi*ScaleTable(2)*f0*t16);
la0s = mod16.*cos(2*pi*ScaleTable(3)*f0*t16);
ti0s = mod16.*cos(2*pi*ScaleTable(4)*f0*t16);
do1s = mod16.*cos(2*pi*ScaleTable(5)*f0*t16);
re1s = mod16.*cos(2*pi*ScaleTable(6)*f0*t16);
mi1s = mod16.*cos(2*pi*ScaleTable(7)*f0*t16);
fa1s = mod16.*cos(2*pi*ScaleTable(8)*f0*t16);
so1s = mod16.*cos(2*pi*ScaleTable(9)*f0*t16);
la1s = mod16.*cos(2*pi*ScaleTable(10)*f0*t16);
tb1s = mod16.*cos(2*pi*ScaleTable(11)*f0*t16);
ti1s = mod16.*cos(2*pi*ScaleTable(12)*f0*t16);
do2s = mod16.*cos(2*pi*ScaleTable(13)*f0*t16);
re2s = mod16.*cos(2*pi*ScaleTable(14)*f0*t16);
mi2s = mod16.*cos(2*pi*ScaleTable(15)*f0*t16);
fa2s = mod16.*cos(2*pi*ScaleTable(16)*f0*t16);
so2s = mod16.*cos(2*pi*ScaleTable(17)*f0*t16);
la2s = mod16.*cos(2*pi*ScaleTable(18)*f0*t16);
ti2s = mod16.*cos(2*pi*ScaleTable(19)*f0*t16);
do3s = mod16.*cos(2*pi*ScaleTable(20)*f0*t16);
blks = zeros(1,k);
% Blank Block
blkblock = [blkf blkf blkf blkf blkf blkf blkf blkf...
blkf blkf blkf blkf blkf blkf blkf blkf];
% Base Melody
cello = [do1f do1f so0f so0f la0f la0f mi0f mi0f...
fa0f fa0f do0f do0f fa0f fa0f so0f so0f];
% So-FUCKING-Long Melody 
violin = [mi2f mi2f re2f re2f do2f do2f ti1f ti1f...
la1f la1f so1f so1f la1f la1f ti1f ti1f ...%
do2f do2f ti1f ti1f la1f la1f so1f so1f...
fa1f fa1f mi1f mi1f fa1f fa1f re1f re1f ...%
do1f mi1f so1f fa1f mi1f do1f mi1f re1f...
do1f la0f do1f so1f fa1f la1f so1f fa1f...%
mi1f do1f re1f ti1f do2f mi2f so2f so1f...
la1f fa1f so1f mi1f do1f do2f blkf blke ti1e ...%
do2e ti1e do2e do1e ti0e so1e re1e mi1e...
do1e do2e ti1e la1e ti1e mi2e so2e la2e...
fa2e mi2e re2e fa2e mi2e re2e do2e ti1e...
la1e so1e fa1e mi1e re1e fa1e mi1e re1e... %%
do1e re1e mi1e fa1e so1e re1e so1e fa1e...
mi1e la1e so1e fa1e so1e fa1e mi1e re1e...
do1e la0e la1e ti1e do2e ti1e la1e so1e...
fa1e mi1e re1e la1e so1e la1e so1e fa1e...%
mi1f mi2e blke re2f re2f blkf do1f mi2f mi2f...
la2f la2f so2f so2f la2f la2f ti2f ti2f...%
do3e blke do2e blke ti1f ti1f blkf la1f do2f do2f...
do2f do2f do2f do2f do2f fa2f re2f so2f...%
so2e mi2s fa2s so2e mi2s fa2s so2s so1s la1s ti1s ...
do2s re2s mi2s fa2s mi2e do2s re2s...
mi2e mi1s fa1s so1s la1s so1s fa1s so1s mi1s fa1s so1s...
fa1e la1s so1s fa1e mi1s re1s mi1s re1s do1s re1s mi1s fa1s so1s la1s...
fa2e la1s so1s la1e ti1s do2s so1s la1s ti1s do2s re2s mi2s fa2s so2s...%
mi2e do2s re2s mi2e re2s do2s re2s ti1s do2s re2s mi2s re2s do2s ti1s...
do2e la1s ti1s do2e do1s re1s mi1s fa1s mi1s re1s mi1s do2s ti1s do2s...
la1e do2s ti1s la1e so1s fa1s so1s fa1s mi1s fa1s so1s la1s ti1s do2s...
la2e do2s ti1s do2e ti1s la1s ti1s do2s re2s do2s ti1s do1s la1s ti1s...%%
do2e blke blkf ti1e blke blkf la1e blke blkf do2e blke blkf...
do1e blke blkf do1e blke blkf do1e blke blkf do1e blke blkf...%
blkf so1e blke blkf so1e blke blkf mi1e blke blkf so1e blke...
blkf fa1e blke blkf mi1e blke blkf fa1e blke blkf re2e blke...%
mi2e mi1e fa1e mi1e re1e re2e mi2e re2e do2e mi1e do1e do2e ti1e so0e fa0e so0e...
la0e la1e so1e la1e so1e so0e fa0e so0e do1e la1e so1e la1e ti1e ti0e la0e ti0e...%
do1e do2e re2e do2e ti1e ti0e do1e ti0e la0e la1e so1e la1e ti1e ti0e mi1e re1e...
do1e do2e re2e fa2e mi2e mi1e so1e mi2e do2e fa2e mi2e fa2e re2e so1e fa1e so1e...%
mi1e so1e so1e so1e so1e so1e so1e so1e mi1e mi1e mi1e mi1e mi1e mi1e so1e so1e...
fa1e fa1e fa1e do2e do2e do2e do2e do2e do2e do2e la1e la1e so1e so1e re2e ti1e...%%
so1e mi2e mi2e mi2e re2e re2e re2e re2e do2e do2e do2e do2e so2e so2e so2e so2e...
la2e la2e la2e la2e so2e so2e so2e so2e la2e la2e la2e la2e ti2e ti1e ti1e ti1e...%
do2e do1s re1s mi1e do1e ti0e ti1s do2s re2e ti1e la1e la0s ti0s do1e la0e ti0e so1s fa1s mi1e re1e...
do1e mi1s re1s do1e fa1e mi1e do1s re1s mi1e so1e fa1e la1s so1s fa1e mi1e re1e so1s fa1s mi1e re1e...%
mi1e do2s ti1s do2e mi1e so1e so1s la1s ti1e so1e mi1e do2s re2s mi2e do2e mi2e mi2s re2s do2e ti1e...
la1e la1s so1s la1e ti1e do2e mi2s re2s do2e mi2e fa2e do2s ti1s la1e la1e so1e re1e so1e so1e...%
so1f so1f so1f so1f do1f do1f do1f so1f...
fa1f fa1f so1f so1f fa1f do1f do1f do1e ti0e...%
do1f do2f ti1f ti1f la1f la1f so1f so1f...
do1f do1e re1e mi1f mi1f do2f do2f ti1f ti1f...%%
do2f];
% cello
c1 = [cello cello cello cello cello...
cello cello cello cello cello...
cello cello cello cello cello...
cello cello cello cello cello...
cello cello cello blkf];
% violin1
v1 = [blkblock violin blkblock blkblock];
% violin2
v2 = [blkblock blkblock violin blkblock];
% violin3
v3 = [blkblock blkblock blkblock violin];
% Get dirty
s = c1+v1+v2+v3;
s = s/max(s);
sound(s,fs);
