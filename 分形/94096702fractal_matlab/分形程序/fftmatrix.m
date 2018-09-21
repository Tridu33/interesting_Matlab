function fftmatrix(varargin)
% FFTMATRIX  Plot columns of the Finite Fourier Transform matrix.
% FFTMATRIX(N) plots all the columns of the FFT matrix of order N.
% FFTMATRIX(N,J) plots only the (J+1)-st column.
% FFTMATRIX with no arguments defaults to FFTMATRIX(10,4).
% Uicontrols allow N and J to be changed.
%
% F = fft(eye(n,n)) is a complex matrix whose elements are powers of
% omega = exp(-2*pi*i/n), an n-th root of unity.  Connecting the elements
% of one column generates a subgraph of the graph on n points.  If n is
% prime, connecting the elements of all columns generates the complete
% graph on n points.  If n is not prime, the sparsity of the graph of
% all columns is related to the speed of the FFT algorithm.

% Initialize uicontrols

if nargin < 1 | isnumeric(varargin{1})
   if nargin < 1, n = 10; else n = varargin{1}; end
   if nargin < 2, j = 4; else j = varargin{2}; end
   shg
   clf reset

   h(1) = uicontrol('units','norm','pos',[.18 .04 .06 .06], ...
          'fontsize',12,'string','<','callback','fftmatrix(''n--'')');
   h(2) = uicontrol('units','norm','pos',[.25 .04 .12 .06], ...
          'fontsize',12,'userdata',n, ...
          'callback','fftmatrix(''n++'')');
   h(3) = uicontrol('units','norm','pos',[.38 .04 .06 .06], ...
          'fontsize',12,'string','>','callback','fftmatrix(''n++'')');
   h(5) = uicontrol('units','norm','pos',[.48 .04 .06 .06], ...
          'fontsize',12,'string','<','callback','fftmatrix(''j--'')');
   h(6) = uicontrol('units','norm','pos',[.55 .04 .12 .06], ...
          'style','toggle','fontsize',12,'userdata',j, ...
          'callback','fftmatrix(''all'')');
   h(7) = uicontrol('units','norm','pos',[.68 .04 .06 .06], ...
          'fontsize',12,'string','>','callback','fftmatrix(''j++'')');
   h(8) = uicontrol('units','norm','pos',[.81 .04 .10 .06], ...
          'string','close','callback','close');

   set(gcf,'color','white','name','FFT Matrix', ...
      'menu','none','numbertitle','off','userdata',h);
else
   h = get(gcf,'userdata');
end

% Decrement or increment n or j.

n = get(h(2),'userdata');
j = get(h(6),'userdata');
all = get(h(6),'val')==1;
if nargin == 1 & ~isnumeric(varargin{1})
   arg = varargin{1};
   if isequal(arg,'n--')
      n = n-1;
      j = min(n-1,j);
   elseif isequal(arg,'n++')
      if j==n-1, j = j+1; end
      n = n+1;
   elseif isequal(arg,'j--')
      j = j-1;
   elseif isequal(arg,'j++')
      j = j+1;
   end
end
onf = {'on','off'};
set(h(1),'enable',onf{(n==1)+1})
set(h(2),'string',['n = ' num2str(n)],'userdata',n)
set(h(5),'enable',onf{(j==1)+1})
set(h(6),'string',['j = ' num2str(j)],'userdata',j)
set(h(7),'enable',onf{(j==n-1)+1})
if all
   set(h([5 7]),'enable','off')
   set(h(6),'string',['j = 1:' num2str(n)])
end

% Plot one column or all the columns

F = fft(eye(n));
if all
   plot(real(F),imag(F))
elseif j > 0
   c = get(gca,'colororder');
   q = size(c,1);
   plot(real(F(:,j+1)),imag(F(:,j+1)),'color',c(rem(j,q)+1,:))
else % j == 0
   plot(1,0,'.','markersize',12);
end
axis(1.2*[-1 1 -1 1])
axis square
axis off

% Label the nodes

hold on
if n > 1, z = F(:,2); else z = 1; end
plot(real(z),imag(z),'bo')
z = 1.15*z - .035;
for k = 0:n-1
   text(real(z(k+1)),imag(z(k+1)),num2str(k),'color',[0 2/3 0])
end
hold off
