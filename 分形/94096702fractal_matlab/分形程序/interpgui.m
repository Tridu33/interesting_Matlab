function interpgui(arg1,arg2)
%INTERPGUI  Behavior of interpolating functions.
%   Demonstrates interpolation by a piecewise linear interpolant,
%   a polynomial, a spline, and a shape preserving Hermite cubic.
%   INTERPGUI(x,y) starts with a plot of y vs. x.
%   INTERPGUI(y) starts with equally spaced x's.
%   INTERPGUI(n) starts with y = zeros(1,n).
%   INTERPGUI with no arguments starts with eight zeros.
%   The interpolation points can be varied with the mouse.
%   If x is specified, it remains fixed.
%
%   See also SPLINETX, PCHIPTX, POLYINTERP, PIECELIN.

if nargin == 0 | isnumeric(arg1)

   % Interpret arguments

   if nargin == 0
      % interpgui with no arguments
      n = 8;
      x = 1:n;
      y = zeros(1,n);
   elseif length(arg1) == 1
      % interpgui(n)
      n = arg1;
      x = 1:n;
      y = zeros(1,n);
   elseif nargin == 1
      % interpgui(y)
      n = length(arg1);
      x = 1:n;
      y = arg1(:)';
   elseif length(arg1) == length(arg2)
      % interpgui(x,y)
      [x,k] = sort(arg1(:)');
      y = arg2(k)';
   else
      error('Two arguments must have same length')
   end
   arg1 = [];

   % Initialize figure

   shg
   clf reset
   set(gcf,'doublebuffer','on', ...
     'name','Interp gui', 'numbertitle','off', ...
     'windowbuttondown',['interpgui(''move''); set(gcf,' ...
        '''windowbuttonmotion'',''interpgui(''''move'''')'')'], ...
     'windowbuttonup','set(gcf,''windowbuttonmotion'','''')');

   % Initialize plots

   n = length(x);
   h = diff(x);
   u = zeros(1,128*(n+1));
   j = 1:128;
   s = (1+sin((j-65)/128*pi))/2;
   u(j) = x(1)+(s-1)*h(1);
   for k = 1:n-1
      u(128*k+j) = x(k)+s*h(k);
   end
   u(128*n+j) = x(n)+s*h(n-1);
   p = plot(x,y,'o',u,zeros(4,length(u)),'-');
   ymin = min(y);
   ymax = max(y);
   ydel = ymax-ymin;
   if ydel == 0; ydel = 1; end
   axis([min(u) max(u) ymin-0.5*ydel ymax+0.5*ydel])
   title('Interpolation')

   % Controls

   uicontrol('units','normal','pos',[.68 .13 .12 .18], ...
     'style','frame','background','white')
   F = {'linear','poly','spline','pchip'};
   pos = [.69 .26 .09 .04];
   vis = 0;
   for k = 1:4
      uicontrol('units','normal','pos',pos, ...
         'style','check','string',F{k},'value',vis, ...
         'background','white','foreground',get(p(k+1),'color'), ...
         'callback','interpgui(''cb'')');
      pos(2) = pos(2)-.04;
   end
   uicontrol('units','normal','pos',[.85 .01 .10 .06], ...
      'style','push','string','close','tag','reset/close', ...
      'callback','close(gcf)');

   % Remember original data

   xfree = (nargin < 2);
   set(gcf,'userdata',xfree)
   set(gca,'userdata',{x,y})
end

p = flipud(get(gca,'children'));
x = get(p(1),'xdata');
y = get(p(1),'ydata');
n = length(x);
h = diff(x);
u = zeros(1,128*(n+1));
j = 1:128;
s = (1+sin((j-65)/128*pi))/2;
u(j) = x(1)+(s-1)*h(1);
for k = 1:n-1
   u(128*k+j) = x(k)+s*h(k);
end
u(128*n+j) = x(n)+s*h(n-1);

if isequal(arg1,'reset')

   % Restore original data

   xy = get(gca,'userdata');
   x = xy{1};
   y = xy{2};
   set(findobj('tag','reset/close'),'string','close', ...
      'callback','close(gcf)');

elseif isequal(arg1,'move')

   % Respond to mouse motion

   z = get(gca,'currentpoint');
   z = z(1,:);
   p = flipud(get(gca,'children'));
   e = abs(x-z(1));
   k = min(find(e == min(e)));
   xfree = get(gcf,'userdata');
   if xfree
      x(k) = z(1);
   end
   y(k) = z(2);
   set(findobj('tag','reset/close'),'string','reset', ...
      'callback','interpgui(''reset'')');

end

ax = axis;
set(p(1),'xdata',x,'ydata',y)
set(p(2),'xdata',u,'ydata',piecelin(x,y,u));
set(p(3),'xdata',u,'ydata',polyinterp(x,y,u));
set(p(4),'xdata',u,'ydata',splinetx(x,y,u));
set(p(5),'xdata',u,'ydata',pchiptx(x,y,u));
axis(ax);

% Visibility

b = flipud(get(gcf,'children'));
onf = {'off','on'};
for k = 1:4
   % Interpolants
   set(p(k+1),'visible',onf{get(b(k+2),'value')+1})
end
