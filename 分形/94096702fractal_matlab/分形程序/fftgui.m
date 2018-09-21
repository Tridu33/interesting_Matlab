function fftgui(y)
%FFTGUI  Demonstration of Finite Fourier Transform.
%  FFTGUI(y) plots real(y), imag(y), real(fft(y)) and imag(fft(y)).
%  FFTGUI, without any arguments, uses y = zeros(1,32).
%  When any point is moved with the mouse, the other plots respond.
%
%  Inspired by Java applet by Dave Hale, Stanford Exploration Project,
%     http://sepwww.stanford.edu/oldsep/hale/FftLab.html

if nargin == 0
   % Default initial y is all zeros.
   y = zeros(1,32);
end
if ~isempty(y)
   if isequal(y,'reset')
      % Restore original data
      y = get(0,'userdata');
      set(gcf,'userdata',y);
      set(findobj('tag','fftguirc'),'string','close', ...
         'callback','close(gcf)')
   else
      % Save input data.
      y = y(:)';
      set(0,'userdata',y);

      % Initialize figure.
      clf reset
      set(gcf, ...
        'doublebuffer','on', ...
        'name','FFT gui', ...
        'menu','none', ...
        'numbertitle','off', ...
        'userdata',y, ...
        'units','normalized', ...
        'pos',[.05 .25 .90 .65], ...
        'doublebuffer','on', ...
        'windowbuttondownfcn', ...
        'fftgui([]); set(gcf,''windowbuttonmotionfcn'',''fftgui([])'')', ...
        'windowbuttonupfcn', ...
        'set(gcf,''windowbuttonmotionfcn'','''')')
      uicontrol('tag','fftguirc','string','close','callback','close(gcf)');
   end
   
   % Initialize four subplots

   n = length(y);
   x = 1:n;
   z = fft(y);
   
   subplot(221)
   u = real(y);
   plot([0 n+1],[0 0],'k-', [x;x],[0*u;u],'c-', x,u,'b.','markersize',16)
   axis([0 n+1 -1 1])
   set(gca,'xtick',[])
   set(gca,'ytick',[])
   title('real(y)','fontname','courier','fontweight','bold')
   
   subplot(222)
   u = imag(y);
   plot([0 n+1],[0 0],'k-', [x;x],[0*u;u],'c-', x,u,'b.','markersize',16)
   axis([0 n+1 -1 1])
   set(gca,'xtick',[])
   set(gca,'ytick',[])
   title('imag(y)','fontname','courier','fontweight','bold')
   
   subplot(223)
   u = real(z);
   plot([0 n+1],[0 0],'k-', [x;x],[0*u;u],'c-', x,u,'b.','markersize',16)
   axis([0 n+1 -2 2])
   set(gca,'xtick',[])
   set(gca,'ytick',[])
   title('real(fft(y))','fontname','courier','fontweight','bold')
   
   subplot(224)
   u = imag(z);
   plot([0 n+1],[0 0],'k-', [x;x],[0*u;u],'c-', x,u,'b.','markersize',16)
   axis([0 n+1 -2 2])
   set(gca,'xtick',[])
   set(gca,'ytick',[])
   title('imag(fft(y))','fontname','courier','fontweight','bold')
  
else

   % Respond to mouse motion.
   y = get(gcf,'userdata');
   n = length(y);
   pt = get(gcf,'currentpoint');
   pos = get(gca,'pos');
   p = round((n+1)*(pt(1)-pos(1))/pos(3));
   q = 2*(pt(2)-pos(2))/pos(4)-1;
   kase = 1 + (pt(1)>.5) + 2*(pt(2)<.5);
   if (p > 0) & (p < n+1) & (abs(q) <= 1)
      switch kase
         case 1 
            y(p) = q+i*imag(y(p));
            z = fft(y);
         case 2 
            y(p) = real(y(p))+i*q;
            z = fft(y);
         case 3
            z = fft(y);
            z(p) = 2*q+i*imag(z(p));
            y = ifft(z);
         case 4 
            z = fft(y);
            z(p) = real(z(p))+i*2*q;
            y = ifft(z);
      end
      set(gcf,'userdata',y)
      axs = get(gcf,'children');
      for k = 1:4
         h(:,k) = get(axs(k),'children');
      end
      set(h(1,4),'ydata',real(y))
      set(h(1,3),'ydata',imag(y))
      set(h(1,2),'ydata',real(z))
      set(h(1,1),'ydata',imag(z))
      for k = 1:n
         set(h(n+2-k,4),'ydata',[0 real(y(k))])
         set(h(n+2-k,3),'ydata',[0 imag(y(k))])
         set(h(n+2-k,2),'ydata',[0 real(z(k))])
         set(h(n+2-k,1),'ydata',[0 imag(z(k))])
      end
      set(findobj('tag','fftguirc'),'string','reset', ...
         'callback','fftgui(''reset'')')
   end
end
