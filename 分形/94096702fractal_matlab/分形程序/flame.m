function flame(r0)
% FLAME  A stiff ordinary differential equation.
% FLAME(r0) specifies the initial radius is r0.  Default r0 = .02.
% A ball of fire grows until its radius is just large enough that all of
% the oxygen available through the surface is consumed by combustion in
% the interior.  The equation for the radius is rdot = r^2 - r^3.
% The problem becomes stiff as the radius approaches its limiting value.

if nargin < 1, r0 = .02; end
t = (0:.002:2)/r0;
opts = odeset('reltol',1.e-5,'outputfcn',@flameplot);
ode23s(@flameeqn,t,r0,opts);
uicontrol('string','close','callback','close(gcf)')

% ------------------------------

function rdot = flameeqn(t,r);
%FLAMEEQN   ODE for expanding flame.
rdot = r.^2-r.^3;

% ------------------------------

function fin = flameplot(t,r,job)
%FLAMEPLOT   Plot the expanding flame.

persistent r0 rho theta x y z p s

if isequal(job,'init')

   shg
   set(gcf,'double','on','color','black')
   set(gca,'color','black')
   r0 = r;
   m = 30;
   [rho,theta] = ndgrid((0:m)'/m, pi*(-m:m)/m);
   x = rho.*sin(theta);
   y = rho.*cos(theta);
   z = 1-rho/r0;
   p = pcolor(x,y,z);
   shading interp
   colormap(hot)
   axis square
   axis off
   s = title(sprintf('t = %8.2f   r = %10.6f',0,r0),'fontsize',16);
   set(s,'color','white');
   fin = 0;

elseif isequal(job,'done')

   fin = 1;

else

   for k = 1:length(t)
      z = max(0,1-rho/r(k));
      set(p,'cdata',z)
      set(s,'string',sprintf('t = %8.1f   r = %10.6f',t(k),r(k)));
      drawnow
   end
   fin = 0;

end
