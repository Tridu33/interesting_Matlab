% NCMLOGO
% L-shaped membrane on the cover of the print
% version of Numerical Computing with MATLAB.
% Activate the cameratoolbar and move the camera.

% Set up the figure window

clf
shg
set(gcf,'color',[0 0 1/4],'colormap',jet(8))
axes('pos',[0 0 1 1])
axis off
daspect([1 1 1])

% Compute MathWorks logo

L = rot90(membranetx(1,32,10,10),2);

% Filled contour plot with transparent lifted patches

b = (1/16:1/8:15/16)';
hold on
for k = 1:8
   [c,h(k)] = contourf(L,[b(k) b(k)]);
   if strcmp(get(h(k),'Type'),'hggroup')
     h(k) = get(h(k),'Children');
   end
   m(k) = length(get(h(k),'xdata'));
   set(h(k),'linewidth',2,'edgecolor','w', ...
      'facealpha',.5,'zdata',4*k*ones(m(k),1))
end
hold off
view(12,30)
