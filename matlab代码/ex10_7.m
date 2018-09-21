x=linspace(0,4*pi,100);
[x,y]=meshgrid(x);
z=sin(x);
axes('view',[-37.5,30]);
hs=surface(x,y,z,'FaceColor','w','EdgeColor','flat');
grid on;
set(get(gca,'XLabel'),'String','X-axis');  %设置X轴说明
set(get(gca,'YLabel'),'String','Y-axis');  %设置Y轴说明
set(get(gca,'ZLabel'),'String','Z-axis');  %设置Z轴说明
title('mesh-surf');
pause
set(hs,'FaceColor','flat'); 
