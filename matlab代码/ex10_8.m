[x,y]=meshgrid([-3:.5:3]);
z=x.^2-2*y.^2;
fh=figure('Position',[350 275 400 300],'Color','w');
ah=axes('Color',[0.8,0.8,0.8]);
h=surface('XData',x,'YData',y,'ZData',z,'FaceColor',...
get(ah,'Color')+0.2,'EdgeColor','k','Marker','o');
view(45,15)
