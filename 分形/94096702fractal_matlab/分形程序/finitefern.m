function F = finitefern(varargin)
%FINITEFERN   MATLAB implementation of the Fractal Fern.
%   Michael Barnsley, "Fractals Everywhere", Academic Press, 1993.
%
%   FINITEFERN with no arguments plots 100000 points.
%   FINITEFERN(N) plots N points.
%   FINITEFERN(N,'s') shows each step.
%
%   F = FINITEFERN(N,r,c) returns an r-by-c sparse logical
%   bit map array that can be viewed with
%      spy(F)
%   or
%      image(F)
%      colormap([1 1 1; 0 2/3 0])
%   F can be saved in PNG (Portable Network Graphics) format with
%      imwrite(full(F),'myfern.png','png','bitdepth',1)
%
%   See also: FERN.

showstep = (nargin >= 1) && ischar(varargin{end});
if showstep || (nargout == 0)
   clf
   shg
   set(gcf,'color','white','doublebuffer','on')
   darkgreen = [0 2/3 0];
   darkred = [2/3 0 0];
end
if showstep
   finish = uicontrol('style','toggle','string','finish', ...
      'value',0,'background','white');
end
if (nargin >= 1) && ~ischar(varargin{1})
   n = varargin{1};
else
   n = 100000;
end

p  = [ .85  .92  .99  1.00];
A1 = [ .85  .04; -.04  .85];  b1 = [0; 1.6];
A2 = [ .20 -.26;  .23  .22];  b2 = [0; 1.6];
A3 = [-.15  .28;  .26  .24];  b3 = [0; .44];
A4 = [  0    0 ;   0   .16];

x = [.5; .5];
xs = zeros(2,n);
xs(:,1) = x;
for j = 2:n
   r = rand;
   if r < p(1)
      x = A1*x + b1;
   elseif r < p(2)
      x = A2*x + b2;
   elseif r < p(3)
      x = A3*x + b3;
   else
      x = A4*x;
   end
   xs(:,j) = x;
   if showstep
      h = plot(xs(1,1:n-1),xs(2,1:n-1),'.',x(1),x(2),'o');
      set(h(1),'markersize',6,'color',darkgreen);
      set(h(2),'color',darkred);
      axis([-3 3 0 10])
      axis off
      showstep = get(finish,'value') == 0;
      if ~showstep, delete(finish), end
      pause(.01)
   end
end

if nargout == 0
   plot(xs(1,:),xs(2,:),'.','markersize',1,'color',darkgreen);
   axis([-3 3 0 10])
   axis off
else
   if nargin < 3
      r = 768; c = 1024;
   else
      r = varargin{2}; c = varargin{3};
   end
   j = round((xs(1,:)+3)/6*c);
   i = round((9-.9*xs(2,:)+.5)/10*r);
   F = sparse(i,j,1,r,c)~=0;
end
