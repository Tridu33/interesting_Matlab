N=128;                         % 采样点数
T=1;                                 % 采样时间终点
t=linspace(0,T,N);                % 给出N个采样时间ti(I=1:N)
x=12*sin(2*pi*10*t+pi/4)+5*cos(2*pi*40*t);  % 求各采样点样本值x
dt=t(2)-t(1);                   % 采样周期
f=1/dt;                          % 采样频率(Hz)
X=fft(x);                        % 计算x的快速傅立叶变换X
F=X(1:N/2+1);                   % F(k)=X(k)(k=1:N/2+1)
f=f*(0:N/2)/N;                  % 使频率轴f从零开始
plot(f,abs(F),'-*')            % 绘制振幅-频率图
xlabel('Frequency');
ylabel('|F(k)|')
