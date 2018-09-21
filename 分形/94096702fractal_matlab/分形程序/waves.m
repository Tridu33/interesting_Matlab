function waves
% WAVES  Wave equation in one and two space dimensions.
%   Solutions of the one- or two-dimensional wave equation are expressed
%   as a time-varying weighted sums of the first four eigenfunctions.
%   The one-dimensional domain is an interval of length pi, so the k-th
%   eigenvalue and eigenfunction are lambda(k) = k^2 and u(k) = sin(k*x).
%   The two-dimensional domains include a pi-by-pi square, a unit disc,
%   a three-quarter circular sector and the L-shaped union of three squares.
%   The eigenfunctions of the square are sin(m*x)*sin(n*y).  With polar
%   coordinates, the eigenfunctions of the disc and the sector involve Bessel
%   functions.  The eigenfunctions of the L-shaped domain also involve
%   Bessel functions and are computed by the MATLAB function membranetx.m.
%   The first eigenfunction of the L-shaped domain is the MathWorks logo.

% 2-D eigenvalues and eigenfunctions

m = 11;   % Determines number of grid points
speed = 1;
bvals = [1; 0; 0; 0; 0];
t = 0;

while bvals(5) == 0

   % Initialize figure

   shg
   clf reset
   set(gcf,'doublebuffer','on','menubar','none','tag','', ...
       'numbertitle','off','name','Waves','colormap',hot(64))
   for k = 1:5
      b(k) = uicontrol('style','toggle','value',bvals(k), ...
          'units','normal','position',[.15*k .01 .14 .05]);
   end
   set(b(1),'style','pop','string', ...
      {'1-d','square','disc','sector','L','bizcard'})
   set(b(2),'string','modes/wave')
   set(b(3),'string','slower')
   set(b(4),'string','faster')
   set(b(5),'string','close')
   if bvals(3)==1
      speed = speed/sqrt(2);
      set(b(3),'value',0);
   end
   if bvals(4)==1
      speed = speed*sqrt(2);
      set(b(4),'value',0);
   end
   bvals = cell2mat(get(b,'value'));
   region = bvals(1);
   modes = bvals(2)==0;

   if region == 1
  
      % 1-D

      x = (0:4*m)/(4*m)*pi;
      orange = [1 1/3 0];
      gray = get(gcf,'color');
      if modes

         % 1-D modes
   
         for k = 1:4
            subplot(2,2,k)
            h(k) = plot(x,zeros(size(x)));
            axis([0 pi -3/2 3/2])
            set(h(k),'color',orange,'linewidth',3)
            set(gca,'color',gray','xtick',[],'ytick',[])
         end
         delta = 0.005*speed;
         bvs = bvals;
         while all(bvs == bvals)
            t = t + delta;
            for k = 1:4
               u = sin(k*t)*sin(k*x);
               set(h(k),'ydata',u)
            end
            drawnow
            bvs = cell2mat(get(b,'value'));
         end

      else

         % 1-D wave

         h = plot(x,zeros(size(x)));
         axis([0 pi -9/4 9/4])
         set(h,'color',orange,'linewidth',3)
         set(gca,'color',gray','xtick',[],'ytick',[])
         delta = 0.005*speed;
         a = 1./(1:4);
         bvs = bvals;
         while all(bvs == bvals)
            t = t + delta;
            u = zeros(size(x));
            for k = 1:4
               u = u + a(k)*sin(k*t)*sin(k*x);
            end
            set(h,'ydata',u)
            drawnow
            bvs = cell2mat(get(b,'value'));
         end
      end

   elseif region <= 5

      switch region

         case 2
            % Square

            x = (0:2*m)/(2*m)*pi;
            y = x';
            lambda = zeros(4,1);
            V = cell(4,1);
            k = 0;
            for i = 1:2
               for j = 1:2
                  k = k+1;
                  lambda(k) = i^2 + j^2;
                  V{k} = sin(i*y)*sin(j*x);
               end
            end
            ax = [0 pi 0 pi -1.75 1.75];

         case 3
            % Disc, mu = zeros of J_0(r) and J_1(r)

            mu = [bjzeros(0,2) bjzeros(1,2)];
            [r,theta] = meshgrid((0:m)/m,(-m:m)/m*pi);
            x = r.*cos(theta);
            y = r.*sin(theta);
            V = cell(4,1);
            k = 0;
            for j = 0:1
               for i = 1:2
                  k = k+1;
                  if j == 0
                     V{k} = besselj(0,mu(k)*r);
                  else
                     V{k} = besselj(j,mu(k)*r).*sin(j*theta);
                  end
                  V{k} = V{k}/max(max(abs(V{k})));
               end
            end
            lambda = mu.^2;
            ax = [-1 1 -1 1 -1.75 1.75];

         case 4
            % Circular sector , mu = zeros of J_(2/3)(r) and J_(4/3)(r)

            mu = [bjzeros(2/3,2) bjzeros(4/3,2)];
            [r,theta] = meshgrid((0:m)/m,(3/4)*(0:2*m)/m*pi);
            x = r.*cos(theta+pi);
            y = r.*sin(theta+pi);
            V = cell(4,1);
            k = 0;
            for j = 1:2
               for i = 1:2
                  k = k+1;
                  alpha = 2*j/3;
                  V{k} = besselj(alpha,mu(k)*r).*sin(alpha*theta);
                  V{k} = V{k}/max(max(abs(V{k})));
               end
            end
            lambda = mu.^2;
            ax = [-1 1 -1 1 -1.75 1.75];

         case 5
            % L-membrane

            x = (-m:m)/m;
            y = x';
            lambda = zeros(4,1);
            V = cell(4,1);
            for k = 1:4
               [L lambda(k)] = membranetx(k,m,9,9);
               L(m+2:2*m+1,m+2:2*m+1) = NaN;
               V{k} = rot90(L,-1);
            end
            ax = [-1 1 -1 1 -1.75 1.75];
      end

      if modes

         % 2-D modes

         p = [.02 .52 .02 .52];
         q = [.52 .52 .02 .02];
         for k = 1:4
            axes('position',[p(k) q(k) .46 .46]);
            h(k) = surf(x,y,zeros(size(V{k})));
            axis(ax)
            axis off
            view(225,30);
            caxis([-1.5 1]);
         end
         delta = .08*speed;
         mu = sqrt(lambda(:));
         bvs = bvals;
         while all(bvs == bvals)
            t = t + delta;
            for k = 1:4
               U = 1.5*sin(mu(k)*t)*V{k};
               set(h(k),'zdata',U)
               set(h(k),'cdata',U)
            end
            drawnow
            bvs = cell2mat(get(b,'value'));
         end

      else

         % 2-D wave
   
         h = surf(x,y,zeros(size(V{1})));
         axis(ax);
         axis off
         view(225,30);
         caxis([-1.5 1]);
         delta = .02*speed;
         mu = sqrt(lambda(:));
         a = 1.25./(1:4);
         bvs = bvals;
         while all(bvs == bvals)
            t = t + delta;
            U = zeros(size(V{1}));
            for k = 1:4
               U = U + a(k)*sin(mu(k)*t)*V{k};
            end
            set(h,'zdata',U)
            set(h,'cdata',U)
            drawnow
            bvs = cell2mat(get(b,'value'));
         end

      end

   elseif region == 6

      figure
      bizcard
      set(b(1),'value',1)

   end

   % Retain uicontrol values

   bvals = cell2mat(get(b,'value'));

end
close

% -------------------------------

function b = bessj(x,n)
% bessj(x,n) = besselj(n,x)
b = besselj(n,x);


% -------------------------------

function z = bjzeros(n,k)
% BJZEROS  Zeros of the Bessel function.
% z = bjzeros(n,k) is the first k zeros of besselj(n,x)

% delta must be chosen so that the linear search can take
% steps as large as possible without skipping any zeros.
% delta is approx bjzero(0,2)-bjzero(0,1)
delta = .99*pi;

a = n+1;
fa = besselj(n,a);
z = zeros(1,k);
j = 0;
while j < k
   b = a + delta;
   fb = besselj(n,b);
   if sign(fb) ~= sign(fa)
      j = j+1;
      z(j) = fzerotx(@bessj,[a b],n);
   end
   a = b;
   fa = fb;
end
