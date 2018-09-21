function pennymelt(arg)
% PENNYMELT  Heat a penny.
% Finite difference methods for the initial value problem for the
% heat equation.  The initial height is based on measurements made
% at the National Institute of Science and Technology of the depth
% of a mold for a U. S. one cent coin.  You can choose either explicit
% or alternating direction implicit time stepping and either a lighted
% surface plot or a contour plot.
%
% PENNYMELT(delta) uses time step = delta.  Default is delta = 0.25.
%
% What is the limiting value of the height as t -> inf ?
% For what values of delta is the computation stable?

if nargin == 0 | isa(arg,'double')
   clf
   shg
   load penny
   fud.U = flipud(P);
   fud.t = 0;
   set(gcf,'double','on','name','pennymelt','menu','none', ...
      'numbertitle','off','colormap',copper(128),'userdata',fud)
   if nargin == 0
      delta = .250;
   else
      delta = arg;
   end
   uicontrol('style','toggle','string','run','val',0, ...
      'units','norm','pos',[.02 .02 .09 .05],'call','pennymelt(''run'')');
   uicontrol('style','toggle','string','reset','val',0, ...
      'units','norm','pos',[.12 .02 .09 .05],'call','pennymelt(''reset'')');
   uicontrol('style','toggle','string','pause','val',1, ...
      'units','norm','pos',[.22 .02 .09 .05],'call','pennymelt(''pause'')');
   uicontrol('style','toggle','string','surf','val',1, ...
      'units','norm','pos',[.34 .02 .09 .05],'call','pennymelt(''surf'')');
   uicontrol('style','toggle','string','contour','val',0, ...
      'units','norm','pos',[.44 .02 .09 .05],'call','pennymelt(''contour'')');
   uicontrol('style','toggle','string','explicit','val',1, ...
      'units','norm','pos',[.56 .02 .09 .05],'call','pennymelt(''explicit'')');
   uicontrol('style','toggle','string','adi','val',0, ...
      'units','norm','pos',[.66 .02 .09 .05],'call','pennymelt(''adi'')');
   uicontrol('tag','delta','units','norm','pos',[.78 .02 .16 .05], ...
      'style','edit','string',sprintf('delta = %7.3f',delta))
   uicontrol('units','norm','pos',[.945 .020 .03 .025], ...
      'string','-','fontsize',12,'callback','pennymelt(''delta-'')')
   uicontrol('units','norm','pos',[.945 .045 .03 .025], ...
      'string','+','fontsize',12,'callback','pennymelt(''delta+'')')
   uicontrol('style','toggle','units','norm','pos',[.88 .93 .10 .05], ...
      'string','close','tag','klose','call','pennymelt(''close'')')
   arg = 'surf';
end

if isequal(arg,'reset')
   fud = get(gcf,'userdata');
   load penny
   fud.U = flipud(P); 
   fud.t = 0;
   set(gcf,'userdata',fud)
   set(findobj('string','run'),'value',0)
   set(findobj('string','pause'),'value',0)
   if get(findobj('string','surf'),'value') == 1
      arg = 'surf';
   else
      arg = 'contour';
   end
end

if isequal(arg,'close')
   run = findobj('string','run'); 
   if get(run,'value') == 1
      set(run,'value',0)
   else
      close(gcf)
   end
   return
end

if isequal(arg,'pause') | isequal(arg,'run')
   pausep = isequal(arg,'pause');
   if pausep
      set(findobj('string','run'),'value',0)
      set(findobj('string','reset'),'value',0)
      return
   else
      set(findobj('string','pause'),'value',0)
      set(findobj('string','reset'),'value',0)
   end
end

if isequal(arg,'surf') | isequal(arg,'contour')
   fud = get(gcf,'userdata');
   U = fud.U;
   t = fud.t;
   if isequal(arg,'surf')
      set(findobj('string','contour'),'value',0)
      drawnow

      % Lighted surface plot
      
      surfu = surf(U);
      daspect([1,1,128])
      colormap(copper)
      shading interp
      material metal
      lighting gouraud
      view(2)
      axis tight
      axis off
      set(gca,'zlimmode','auto','climmode','manual');
      light('pos',[1,2,2000],'style','inf');
      titl = title(sprintf('t = %10.3f',t));
      set(surfu,'userdata',titl);
      set(gca,'userdata',surfu)
   elseif norm(del2(U)) > 2500
      contour(U,[0 128]);
      text(10,60,{'del2(U) is too large', ...
         'contour(U) takes too much time','revert to surf'}, ...
         'color','red','fontsize',20)
      set(findobj('string','run'),'value',0)
      set(findobj('string','pause'),'value',1)
      set(findobj('string','contour'),'value',0)
      set(findobj('string','surf'),'value',1)

   else
      set(findobj('string','surf'),'value',0)
      drawnow
      
      % Contour plot
      
      contour(U,1:12:255);
      axis square
      set(gca,'xtick',[],'ytick',[])
      title(sprintf('t = %10.3f',t))
   end
   drawnow
   return
end

if isequal(arg,'explicit') | isequal(arg,'adi')
   adi = isequal(arg,'adi');
   if adi
      set(findobj('string','explicit'),'value',0)
   else
      set(findobj('string','adi'),'value',0)
   end
   return
end

if isequal(arg,'delta+') | isequal(arg,'delta-')
   deltabox = findobj('tag','delta');
   str = get(deltabox,'string');
   k = strfind(str,'=');
   if ~isempty(k), str = str(k+1:end); end
   temp = str2num(str);
   if isequal(arg,'delta+')
      temp = temp + .001;
   else
      temp = temp - .001;
   end
   if isempty(temp)
      set(deltabox,'string',sprintf('delta = ???'))
   else
      delta = temp;
      set(deltabox,'string',sprintf('delta = %7.3f',delta))
   end
   return
end

run = findobj('string','run');
while get(run,'value') == 1
   fud = get(gcf,'userdata');
   U = fud.U;
   t = fud.t;

   % Finite difference indices

   [p,q] = size(U);
   n = [2:p p];
   s = [1 1:p-1];
   e = [2:q q];
   w = [1 1:q-1];

   deltabox = findobj('tag','delta');
   str = get(deltabox,'string');
   k = strfind(str,'=');
   if ~isempty(k), str = str(k+1:end); end
   temp = str2num(str);
   if isempty(temp)
      set(deltabox,'string',sprintf('delta = ???'))
   else
      delta = temp;
      set(deltabox,'string',sprintf('delta = %7.3f',delta))
   end
   h = 1;
   sigma = delta/h^2;

   % Tridiagonal coefficients
   a = -sigma*ones(p,1);
   b = (1+2*sigma)*ones(p,1);
   c = a;
   
   % Diffusion
   
   if get(findobj('string','explicit'),'value') == 1

      % Explicit

      U = U + sigma*(U(n,:)+U(s,:)+U(:,e)+U(:,w)-4*U);
      t = t + delta;

   else

      % Alternating Directions Implicit (ADI)

      for i = 1:p
         d = sigma*U(i,e) + (1-2*sigma)*U(i,:) + sigma*U(i,w);
         d(1) = d(1) + sigma*U(i,1);
         d(p) = d(p) + sigma*U(i,p);
         U(i,:) = tridisolve(a,b,c,d);
      end
      t = t + delta/2;
      for j = 1:p
         d = sigma*U(n,j) + (1-2*sigma)*U(:,j) + sigma*U(s,j);
         d(1) = d(1) + sigma*U(1,j);
         d(p) = d(p) + sigma*U(p,j);
         U(:,j) = tridisolve(a,b,c,d);
      end
      t = t + delta/2;

   end

   % Plot result

   if get(findobj('string','surf'),'value') == 1
      surfu = get(gca,'userdata');
      if isempty(surfu)
         pennymelt('surf')
      end
      surfu = get(gca,'userdata');
      set(surfu,'zdata',U,'cdata',U)
      titl = get(surfu,'userdata');
      set(titl,'string',sprintf('t = %10.3f',t));
   elseif norm(del2(U)) > 2500
      text(10,60,{'del2(U) is too large', ...
         'contour(U) takes too much time','revert to surf'}, ...
         'color','red','fontsize',20)
      set(findobj('string','run'),'value',0)
      set(findobj('string','pause'),'value',1)
      set(findobj('string','contour'),'value',0)
      set(findobj('string','surf'),'value',1)
   else
      contour(U,1:12:255);
      axis square
      set(gca,'xtick',[],'ytick',[])
      title(sprintf('t = %10.3f %10.3f',t));
   end
   fud.U = U;
   fud.t = t;
   set(gcf,'userdata',fud)
   drawnow
end
klose = findobj('tag','klose');
if ~isempty(klose) & get(klose,'value') == 1
   close(gcf)
end
