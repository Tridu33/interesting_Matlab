function rungeinterp(arg)
%RUNGEINTERP  Runge's polynomial interpolation example.
%   F(x) = 1/(1+25*x^2)
%   Polynomial interpolation at equally spaced points, -1 <= x <= 1.
%   Does interpolant converge as number of points is increased?


if nargin == 0

   % Initialize plot and uicontrols

   shg
   clf reset
   set(gcf,'doublebuffer','on','numbertitle','off', ...
       'name','Runge''s interpolation example')
   n = 1;
   u = -1.1:.01:1.1;
   z = rungerat(u);
   h.plot = plot(u,z,'-', 0,1,'o', u,z,'-');
   set(h.plot(1),'color',[.6 .6 .6]);
   set(h.plot(2),'color','blue');
   set(h.plot(3),'color',[0 2/3 0]);
   axis([-1.1 1.1 -0.1 1.1])
   title('1/(1+25*x^2)','interpreter','none')

   h.minus = uicontrol('units','norm','pos',[.38 .01 .06 .05], ...
          'fontsize',12,'string','<','callback','rungeinterp(''n--'')');
   h.n = uicontrol('units','norm','pos',[.46 .01 .12 .05], ...
          'fontsize',12,'userdata',n,'callback','rungeinterp(''n=1'')');
   h.plus = uicontrol('units','norm','pos',[.60 .01 .06 .05], ...
          'fontsize',12,'string','>','callback','rungeinterp(''n++'')');
   h.close = uicontrol('units','norm','pos',[.80 .01 .10 .05], ...
          'fontsize',12,'string','close','callback','close');

   set(gcf,'userdata',h)
   arg = 'n=1';
end

% Update plot.

h = get(gcf,'userdata');

% Number of interpolation points.

n = get(h.n,'userdata');
switch arg
   case 'n--', n = n-2;
   case 'n++', n = n+2;
   case 'n=1', n = 1;
end
set(h.n,'string',['n = ' num2str(n)],'userdata',n);
if n==1
   set(h.minus,'enable','off');
else
   set(h.minus,'enable','on');
end

if n == 1;
   x = 0;
else
   x = -1 + 2*(0:n-1)/(n-1);
end
y = rungerat(x);
u = get(h.plot(1),'xdata');
v = polyinterp(x,y,u);
set(h.plot(2),'xdata',x,'ydata',y);
set(h.plot(3),'xdata',u,'ydata',v);

% ------------------------

function y = rungerat(x);
y = 1./(1+25*x.^2);
