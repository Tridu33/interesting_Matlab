function interp2dgui(arg1,arg2)
%INTERPGUI  Behavior of periodic parametric curves.
%   Demonstrates interpolation by both periodic and nonperiodic
%   splines and shape preserving Hermite cubics.
%   INTERPGUI with no arguments starts with five points in the plane.
%   INTERPGUI(n) starts with n points in the plane.
%   INTERPGUI(z) starts with a plot of imag(z) vs. real(z).
%   INTERPGUI(x,y) starts with a plot of y vs. x.
%   The interpolation points can be varied with the mouse.
%
%   See SPLINETX, PCHIPTX, PERSPLINE, PERPCHIP, INTERPGUI.

if nargin == 0 | isnumeric(arg1)

   % Interpret arguments

   if nargin == 0
      % interpgui with no arguments
      arg1 = 5;
   end
   if length(arg1) == 1
      % interpgui(n)
      n = arg1;
      t = (0:n-1)/(n-1)*2*pi;
      if mod(n,2)==1
         r = 2+1.5*mod(1:n,2);
      else
         r = cos(t+pi/4);
      end
      x = r.*cos(t);
      y = r.*sin(t);
   elseif nargin == 1
      % interpgui(z)
      x = real(arg1(:).');
      y = imag(arg1(:).');
   elseif length(arg1) == length(arg2)
      % interpgui(x,y)
      x = arg1(:)';
      y = arg2(:)';
   else
      error('Two arguments must have same length')
   end
   arg1 = [];

   if ~isequal(get(gcf,'name'),'Interp2dgui')

      % Initialize figure
   
      shg
      clf reset
      set(gcf,'doublebuffer','on', ...
        'name','Interp2dgui', 'numbertitle','off', ...
        'windowbuttondown',['interp2dgui(''move''); set(gcf,' ...
           '''windowbuttonmotion'',''interp2dgui(''''move'''')'')'], ...
        'windowbuttonup','set(gcf,''windowbuttonmotion'','''')');
   
      % Controls
   
      F = {'splinetx','perspline','pchiptx','perpchip'};
      uicontrol('units','normal','pos',[.85 .13 .14 .18], ...
         'style','frame','background','white')
      pos = [.86 .26 .12 .04];
      u = NaN*ones(4,length(t));
      h = plot(x,y,'o',u,u,'-');
      for k = 1:4
         if ~exist(F{k},'file')
            warning('Please provide %s.',F{k})
            enable = 'off';
         else
            enable = 'on';
         end
         uicontrol('units','normal','pos',pos,'enable',enable, ...
            'style','check','string',F{k},'value',0, ...
            'background','white','foreground',get(h(k+1),'color'), ...
            'callback','interp2dgui(''cb'')');
        pos(2) = pos(2)-.04;
      end
      uicontrol('units','normal','pos',[.86 .01 .05,.05], ...
         'style','push','string','<','fontweight','bold','callback', ...
         'n = get(gca,''userdata''); interp2dgui(max(4,n-1))') 
      uicontrol('units','normal','pos',[.93 .01 .05,.05], ...
         'style','push','string','>','fontweight','bold','callback', ...
         'n = get(gca,''userdata''); interp2dgui(n+1)') 
   end

   % Initialize plots

   n = length(x);
   s = 1:n;
   t = 1:1/32:n;
   u = NaN*ones(4,length(t));
   h = plot(x,y,'o',u,u,'-');
   axis square;
   ax = axis;
   d = 0.2*diff(ax);
   axis(ax-[d(1) -d(1) d(3) -d(3)]);
   title('2D Interpolation')
   set(gca,'userdata',n);
   
end

h = flipud(get(gca,'children'));
x = get(h(1),'xdata');
y = get(h(1),'ydata');
n = length(x);
s = 1:n;
t = 1:1/32:n;

if isequal(arg1,'move')

   % Respond to mouse motion

   z = get(gca,'currentpoint');
   z = z(1,:);
   h = flipud(get(gca,'children'));
   e = abs(x-z(1))+abs(y-z(2));
   k = min(find(e == min(e)));
   x(k) = z(1);
   y(k) = z(2);
   if k == 1, x(n) = x(1); y(n) = y(1); end
   if k == n, x(1) = x(n); y(1) = y(n); end

end

ax = axis;
set(h(1),'xdata',x,'ydata',y)
set(h(2),'xdata',splinetx(s,x,t),'ydata',splinetx(s,y,t));
if exist('perspline','file')
   set(h(3),'xdata',perspline(s,x,t),'ydata',perspline(s,y,t));
end
set(h(4),'xdata',pchiptx(s,x,t),'ydata',pchiptx(s,y,t));
if exist('perpchip','file')
   set(h(5),'xdata',perpchip(s,x,t),'ydata',perpchip(s,y,t));
end
axis(ax);

% Visibility

b = flipud(get(gcf,'children'));
onf = {'off','on'};
for k = 1:4
   % Interpolants
   set(h(k+1),'visible',onf{get(b(k+2),'value')+1})
end
