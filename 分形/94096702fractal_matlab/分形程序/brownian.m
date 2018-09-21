% BROWNIAN   Two-dimensional random walk.
%   What is the expansion rate of the cloud of particles?

shg
clf
set(gcf,'doublebuffer','on')
delta = .002;
x = zeros(100,2);
h = plot(x(:,1),x(:,2),'.');
axis([-1 1 -1 1])
axis square
stop = uicontrol('style','toggle','string','stop');
while get(stop,'value') == 0
   x = x + delta*randn(size(x));
   set(h,'xdata',x(:,1),'ydata',x(:,2))
   drawnow
end
set(stop,'string','close','value',0,'callback','close(gcf)')
