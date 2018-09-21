function censusgui(callbackarg)
%CENSUSGUI Try to predict the US population in the year 2010.
% This example is older than MATLAB.  It started as an exercise in
% "Computer Methods for Mathematical Computations", by Forsythe,
% Malcolm and Moler, published by Prentice-Hall in 1977.
% The data set has been updated every ten years since then.
% Today, MATLAB makes it easier to vary the parameters and see the
% results, but the underlying mathematical principles are unchanged:
%
%    Using polynomials of even modest degree to predict
%    the future by extrapolating data is a risky business.
%
% The data is from the decennial census of the United States for the
% years 1900 to 2000.  The task is to extrapolate beyond 2000.
% In addition to polynomials of various degrees, you can choose
% interpolation by a cubic spline, interpolation by a shape-preserving
% Hermite cubic, and a least squares fit by an exponential.
% Error estimates attempt to account for errors in the data,
% but not in the extrapolation model.

% Census data for 1900 to 2000.
% The population on April 1, 2000 was 281,421,906, according to:
% http://www.census.gov/main/www/cen2000.html

p = [ 75.995  91.972 105.711 123.203 131.669 150.697 ...
     179.323 203.212 226.505 249.633 281.422]';

t = (1900:10:2000)';   % Census years
x = (1890:1:2019)';    % Evaluation years
w = 2010;              % Extrapolation target
guess = 320;           % Eyeball extrapolation
z = guess;             % Extrapolated value
dmax = length(t)-1;    % Maximum polynomial degree

if nargin == 0

   % Initialize plot and uicontrols

   shg
   clf reset
   set(gcf,'doublebuffer','on','name','Census gui', ...
       'menu','none','numbertitle','off')
   h.plot = plot(t,p,'bo', x,0*x,'k-', w,0,'.', [x;NaN;x],[x;NaN;x],'m:');
   darkgreen = [0 2/3 0];
   darkmagenta = [2/3 0 2/3];
   marksize = get(0,'defaultlinemarkersize');
   set(h.plot(3),'color',darkgreen,'markersize',4*marksize-6)
   set(h.plot(4),'color',darkmagenta)
   axis([min(x) max(x) 0 400])
   title('Predict U.S. Population in 2010')
   ylabel('Millions')

   h.text = text(w-16,z+10,'predict','color',darkgreen,'fontweight','bold');
   h.model = uicontrol('units','norm','pos',[.20 .80 .20 .05], ...
           'style','popup','background','white','string', ...
           {'census data','polynomial','pchip','spline','exponential'}, ...
           'callback','censusgui([])');
   h.deg = uicontrol('units','norm','pos',[.26 .75 .13 .04], ...
           'tag','degree','style','text','background','white', ...
           'userdata',3,'string','degree = 3');
   h.ls = uicontrol('units','norm','pos',[.20 .75 .05 .04], ...
           'style','push','string','<','fontweight','bold', ...
           'callback','censusgui(''<'')');
   h.gt = uicontrol('units','norm','pos',[.40 .75 .05 .04], ...
           'style','push','string','>','fontweight','bold', ...
           'callback','censusgui(''>'')');
   h.err = uicontrol('units','norm','pos',[.20 .65 .20 .05], ...
           'style','check','background','white', ...
           'string','error estimates','callback','censusgui([])');
   set(gcf,'userdata',h);
   uicontrol('style','push','units','normal','pos',[.85 .02 .10 .06], ...
      'string','close','callback','close(gcf)')
   callbackarg = [];

else

   h = get(gcf,'userdata');
 
end

% Polynomial degree

d = get(h.deg,'userdata');
if isequal(callbackarg,'<'), d = d - 1; end
if isequal(callbackarg,'>'), d = d + 1; end
set(h.deg,'userdata',d)

% Update plot with new model

models = get(h.model,'string');
model = models{get(h.model,'value')};
switch model
   case 'census data'
      y = NaN*x;
      z = 320;
   case 'polynomial'
      s = (t-1950)/50;   c = polyfit(s,p,d);
      s = (x-1950)/50;   y = polyval(c,s);
      s = (w-1950)/50;   z = polyval(c,s);
   case 'pchip'
      y = pchip(t,p,x);
      z = pchip(t,p,w);
   case 'spline'
      y = spline(t,p,x);
      z = spline(t,p,w);
   case 'exponential'
      c = polyfit(log(t),log(p),1);
      y = exp(polyval(c,log(x)));
      z = exp(polyval(c,log(w)));
end
set(h.plot(2),'ydata',y);
set(h.plot(3),'ydata',z);
set(h.text,'pos',[w-18,min(max(z+10,20),380)],'string',sprintf('%8.3f',z))

% Update controls

switch model
   case 'census data'
      set(h.err,'vis','off','value',0);
      set([h.deg; h.gt; h.ls],'vis','off');
      set(h.text,'pos',[w-16,z+10],'string','predict')
   case 'polynomial'
      set(h.err,'vis','on','pos',[.20 .68 .20 .05]);
      set(h.deg,'vis','on','string',['degree = ' num2str(d)]);
      set([h.gt; h.ls],'vis','on','enable','on');
      if d == 0, set(h.ls,'enable','off'), end
      if d == dmax, set(h.gt,'enable','off'), end
   otherwise
      set(h.err,'vis','on','pos',[.20 .75 .20 .05]);
      set([h.deg; h.gt; h.ls],'vis','off');
end

% Display error estimates if requested

if get(h.err,'value') == 1
   errest = errorestimates(model,t,p,x,y,d);
   set(h.plot(4),'vis','on','ydata',errest);
else
   set(h.plot(4),'vis','off');
end


% ------------------------------------------------

function errest = errorestimates(model,t,p,x,y,d)
% Provide error estimates for censusgui

switch model
   case 'polynomial'
      if d > 0
         V(:,d+1) = ones(size(t));
         s = (t-1950)/50;
         for j = d:-1:1
            V(:,j) = s.*V(:,j+1);
         end
         [Q,R] = qr(V);
         R = R(1:d+1,:);
         RI = inv(R);
         E = zeros(length(x),d+1);
         s = (x-1950)/50;
         for j = 1:d+1
            E(:,j) = polyval(RI(:,j),s);
         end
         sig = 10;   % Rough estimate
         e = sig*sqrt(1+diag(E*E'));
         errest = [y-e; NaN; y+e];
      else
         errest = [y-NaN; NaN; y+NaN];
      end
   case {'pchip','spline'}
      n = length(t);
      I = eye(n,n);
      E = zeros(length(x),n);
      for j = 1:n
         if isequal(model,'pchip')
            E(:,j) = pchip(t,I(:,j),x);
         else
            E(:,j) = spline(t,I(:,j),x);
         end
      end
      sig = 10;  % Rough estimate
      e = sig*sqrt(1+diag(E*E'));
      errest = [y-e; NaN; y+e];
   case 'exponential'
      V = [ones(size(t)) log(t)];
      [Q,R] = qr(V);
      c = R\(Q'*log(p));
      r = log(p) - V*c;
      E = [ones(size(x)) log(x)]/R(1:2,1:2);
      sig = norm(r);
      e = sig*sqrt(1+diag(E*E'));
      errest = [y.*exp(-e); NaN; y.*exp(e)];
end
