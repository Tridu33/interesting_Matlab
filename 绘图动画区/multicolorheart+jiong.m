axis off;
set(gcf, 'menubar', 'none', 'toolbar', 'none'); % 不显示菜单栏和工具栏
for k = 1 : 100
    h = text(rand, rand, ...
        ['\fontsize{',num2str(unifrnd(20, 50)),'}\fontname{隶书} 囧'], ...
        'color', rand(1, 3), 'Rotation', 360 * rand);
    pause(0.2);
end
