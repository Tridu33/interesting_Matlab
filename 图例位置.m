可以设置legend函数的参数进行大致设置，还可以通过其位置属性进行精确设置。
举例如下：
x=0:pi/20:pi;
y=sin(x);
plot(x,y);
grid on;

% 利用legend函数的参数进行大致设置
legend('sinx',-1); % 位于图形框外面
legend('sinx',0); % 最佳位置
legend('sinx',1); % 右上角
legend('sinx',2); % 左上角
legend('sinx',3); % 左下角
legend('sinx',4); % 右下角

% 利用位置属性进行精确设置
gca=legend( 'sinx', 4 );
set( gca, 'Position', [10, 50, 100, 400]); % [10, 50, 100, 400]为显示的位置坐标 