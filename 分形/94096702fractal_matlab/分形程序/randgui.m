function randgui(randfun)
%RANDGUI   Monte Carlo computation of pi.
%  Generate random points in a cube and count the portion that are
%  also in the inscribed sphere.  The ratio of the volume of the
%  sphere to the volume of the cube is pi/6.  
%
%  RANDGUI with no arguments or RANDGUI('rand') uses MATLAB's
%  built-in random number generator.  RANDGUI('randtx') uses our
%  textbook version of the built-in generator.  RANDGUI('randmcg')
%  and RANDGUI('randssp') use different Lehmer congruential generators,
%  one with good parameters and one with the parameters used years
%  ago by IBM's "RANDU" function.
%
% See also RAND, RANDTX, RANDMCG, RANDSSP.

nmax = 10000;  % Number of samples
m = 25;        % Samples per plot

if nargin < 1, randfun = 'rand'; end

shg
clf reset
set(gcf,'doublebuffer','on','pos',[232 100 560 580],'toolbar','none', ...
   'numbertitle','off','menubar','none','name','Randgui')
ax1 = axes('pos',[.130 .360 .775 .620],'view',[-37.5 30],  ...
   'xlim',[-1 1],'ylim',[-1 1],'zlim',[-1 1],'box','on', ...
   'plotboxaspectratiomode','manual');
h1 = line(NaN,NaN,NaN,'color','red','linestyle','none', ...
   'marker','.','erasemode','none');
h2 = line(NaN,NaN,NaN,'color','blue','linestyle','none', ...
   'marker','.','erasemode','none');
ax2 = axes('pos',[.130 .110 .775 .200],'xlim',[0 nmax],'ylim',[3 3.3]);
h3 = line(NaN,NaN,'color',[0 2/3 0],'linestyle','-','erasemode','none');
h4 = text(.8*nmax,3.25,'','fontsize',14,'erasemode','xor');
line([0 nmax],[pi pi],'color','black','linestyle',':');
line([0 nmax],[3.3 3.3],'color','black','linestyle','-');
rpt = uicontrol('units','norm','pos',[.02 .01 .10 .05], ...
   'style','push','string','repeat','value',0,'userdata',randfun, ...
   'callback','randgui(get(gcbo,''userdata''))');
stop = uicontrol('units','norm','pos',[.14 .01 .10 .05], ...
   'style','toggle','string','stop','value',0);

n = 0;
s = 0;
while n < nmax & get(stop,'value') == 0
   X = 2*feval(randfun,3,m)-1;
   r = sum(X.^2);
   k = (r <= 1);
   pie = 6*(s+cumsum(k))./(n+1:n+m);
   set(h1,'xdata',X(1,k),'ydata',X(2,k),'zdata',X(3,k));
   set(h2,'xdata',X(1,~k),'ydata',X(2,~k),'zdata',X(3,~k));
   set(h3,'xdata',n+1:n+m,'ydata',pie);
   set(h4,'string',sprintf('%7.4f',pie(m)))
   drawnow
   n = n + m;
   s = s + sum(k);
end

set(stop,'style','push','userdata',randfun,'string','close', ...
   'callback','close(gcf)')
