x=0:pi/100:2*pi;
y=2*sin(5*x).*sin(x);
hl=plot(x,y);
hc=uicontextmenu;             %建立快捷菜单
hls=uimenu(hc,'Label','线型');    %建立菜单项
hlw=uimenu(hc,'Label','线宽');
uimenu(hls,'Label','虚线','Call','set(hl,''LineStyle'','':'');');
uimenu(hls,'Label','实线','Call','set(hl,''LineStyle'',''-'');');
uimenu(hlw,'Label','加宽','Call','set(hl,''LineWidth'',2);');
uimenu(hlw,'Label','变细','Call','set(hl,''LineWidth'',0.5);');
set(hl,'UIContextMenu',hc);     %将该快捷菜单和曲线对象联系起来
