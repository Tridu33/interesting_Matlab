t=0:0.01:2*pi;
x=exp(i*t);
y=[x;2*x;3*x]';
plot(y)
grid on;            %加网格线
box on;            %加坐标边框
axis equal          %坐标轴采用等刻度
