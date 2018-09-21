function imagesvd(varargin)
% IMAGESVD   Principle component analysis of monochrome and color images.
%    IMAGESVD('file1.fmt','file2.fmt', ... ) reads the specified image
%    files.  Any format known to IMREAD is acceptable.
%    IMAGESVD, with no arguments, provides popup menu access to several
%    images from the NCM and demos directories.

%    imagesvd('slide') is the callback from the rank slider.
%    imagesvd('menu') is the callback from the popup menu.

if nargin == 0  | ~isequal(varargin{1},'slide')
   if nargin == 0  | ~isequal(varargin{1},'menu')

      % Initialize uicontrols

      shg
      clf
      set(gcf,'doublebuffer','on','numbertitle','off','name','Image SVD');
      if nargin > 0
         L = varargin;
      else
         L = {'detail.mat','durer.mat','fern.png','clown.mat', ...
             'earth.mat','mandrill.mat','gatlin.mat'};
      end
      startwith = 1;
      h.popup = uicontrol('units','norm','pos',[.10 .03 .20 .05], ...
         'style','popup','val',startwith,'string',L, ...
         'callback','imagesvd(''menu'')');
      h.slider = uicontrol('units','norm','pos',[.38 .02 .24 .04], ...
         'style','slider','value',0,'callback','imagesvd(''slide'')');
      h.limit = uicontrol('units','norm','pos',[.62 .02 .05 .04], ...
         'style','text');
      h.rank = uicontrol('units','norm','pos',[.42 .06 .16 .04], ...
         'style','text','string',' ');
      h.close = uicontrol('units','norm','pos',[.80 .03 .10 .05], ...
         'string','close','callback','close');
      set(gcf,'userdata',h)
   end
 
   % Read or load a new image.
   % Monochrome is a single 2-D array of intensities.
   % Color is a 3-D array of red, green and blue intensities.

   h = get(gcf,'userdata');
   L = get(h.popup,'string');
   name = L{get(h.popup,'val')};

   if isempty(findstr(name,'.mat'))
      % Read image file
      X = imread(name);
      X = double(X)/255;

   else
      % Load .mat file containing indexed image 'X' and colormap 'map'.
      % Convert to intensities.
      load(name)
      if norm(diff(map'),1) == 0
         % Monochrome image
         T = map(X,1);
         X = reshape(T,size(X));
      else
         % Color image
         T = [map(X,1) map(X,2) map(X,3)];
         X = reshape(T,[size(X) 3]);
      end
   end

   % Resize large images to reduce computation time.

   [m,n,p] = size(X);
   while m >= 768
      i = 1:2:m-1;
      j = 1:2:n-1;
      X = (X(i,j,:)+X(i+1,j,:)+X(i,j+1,:)+X(i+1,j+1,:))/4;
      [m,n,p] = size(X);
   end

   % Display the input image.

%  imager(X)

   % Slider parameters depend upon size the image.

   mn = min(m,n);
   set(h.slider,'val',1,'min',0,'max',mn,'sliderstep',[1/mn 10/mn])
   set(h.limit,'string',int2str(mn))
   set(h.rank,'string','')

   % Compute the singular value decomposition of the image.

   msg = uicontrol('units','norm','pos',[.25 .56 .50 .10], ...
      'style','text','fontsize',14, ...
      'string',['Computing ' int2str(n*p) '-by-' int2str(m) ' SVD...']);
   drawnow

   X = reshape(X,m,p*n);
   [V,S,U] = svd(X',0);

   % Save the SVD in the figure's user data.

   h.U = U;
   h.S = S;
   h.V = V;
   h.m = m;
   h.n = n;
   h.p = p;
   set(gcf,'userdata',h)
   delete(msg);
end

% Update the plot.

h = get(gcf,'userdata');
U = h.U;
S = h.S;
V = h.V;
m = h.m;
n = h.n;
p = h.p;

% Obtain the rank from the slider.

r = round(get(h.slider,'value'));
set(h.slider,'value',r)
set(h.rank,'string',['rank = ' num2str(r)]);

% Rank r approximation.

k = 1:r;
X = U(:,k)*S(k,k)*V(:,k)';
X = reshape(X,m,n,p);
imager(X)
drawnow


% ------------------------------------

function imager(X)

% Display the image.

X(X<0) = 0;
X(X>1) = 1;
if ndims(X) == 3
   image(X)
else
   image(255*X)
   colormap(gray(256));
end
axis image
axis off
