function greetings(phi)
% GREETINGS  Seasonal holiday fractal.
%   GREETINGS(phi) generates a seasonal holiday fractal that depends
%   upon the parameter phi.  The default value of phi is the golden ratio.
%   What happens for other values of phi?  Try both simple fractions
%   and floating point approximations to irrational values.

if nargin < 1
   phi = (1+sqrt(5))/2;
end

clf
shg
set(gcf,'color','black','doublebuffer','on')
stop = uicontrol('style','toggle', ...
   'units','normal','position',[.95 .95 .04 .04]);
ax = [-60 120 -60 120];

sigma = .4;
n = 100;
z = 0;
while get(stop,'value') == 0 & ...
      min(real(z)) > ax(1) & max(real(z)) < ax(2) & ...
      min(imag(z)) > ax(3) & max(imag(z)) < ax(4)
   z = cumsum(exp(i*(phi*pi*(0:n).^2+sigma)));
   plot(z,'g','linewidth',1)
   hold on
   plot(z(1:100:n+1),'r.','markersize',12);
   hold off
   axis(ax)
   axis off
   text(ax(1)+5,ax(3)+5,'Season''s Greetings','color','white',...
      'fontsize',2*get(0,'defaulttextfontsize'))
   pause(1)
   n = n+100;
end
set(stop,'value',0,'string','X','callback','close(gcf)')
