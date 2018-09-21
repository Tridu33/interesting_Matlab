function floatgui(callbackarg)
%FLOATGUI  Show structure of floating point numbers.
%  The set of positive model floating point numbers is determined
%  by three parameters: t, emin, and emax.  It is the set of rational
%  numbers of the form x = (1+f)*2^e where f = (integer)/2^t,
%  0 <= f < 1, e = integer, and emin <= e <= emax.
%
%  IEEE 754 double precision has t = 52, emin = -1022, emax = 1023.

% Initialize parameters

if nargin == 0
   t = 3;
   emin = -4;
   emax = 2;
   logscale = 0;
else
   t = round(get(findobj('tag','t'),'value'));
   emin = round(get(findobj('tag','emin'),'value'));
   emax = round(get(findobj('tag','emax'),'value'));
   logscale = get(findobj('style','check'),'value');
end

% Position figure window

shg
clf reset
set(gcf,'pos',[50 300 900 250],'name','floatgui', ...
    'numbertitle','off','menubar','none')

% Generate and plot floating point numbers

f = (0:2^t-1)/2^t;
F = [];
for e = emin:emax
   F = [F (1+f)*2^e];
end
for x = F
   text(x,0,'|')
end

% Set axes

set(gca,'pos',[.05 .6 .9 .2])
if logscale
   set(gca,'xscale','log')
   xmin = 1/2^(-emin+.5);
   xmax = 2^(emax+1.5);
else
   set(gca,'xscale','linear')
   xmin = 0;
   xmax = 2^(emax+1);
end
axis([xmin xmax -1 1])

% Set tick marks

fmin = min(F);
fmax = max(F);
xtick = 1;
xticklab = '1';
if fmin < 1
   xtick = [1/2 xtick];
   xticklab = ['1/2|' xticklab];
end
if logscale & (fmin < 1/4)
   xtick = [1/4 xtick];
   xticklab = ['1/4|' xticklab];
end
if fmin < 1/2
   xtick = [fmin xtick];
   xticklab = ['1/' int2str(1/fmin) '|' xticklab];
end
if 2 < fmax
   xtick = [xtick 2];
   xticklab = [xticklab '|2'];
end
if 4 < fmax
   xtick = [xtick 4];
   xticklab = [xticklab '|4'];
end
if max(xtick) < fmax
   xtick = [xtick fmax];
   if fmax == round(fmax)
      fmaxlab = int2str(fmax);
   else
      over = 2^(emax+1);
      fmaxlab = [int2str(over) '-1/' int2str(1/(over-fmax))];
   end
   xticklab = [xticklab '|' fmaxlab];
end
set(gca,'xtick',xtick,'xticklabel',xticklab,'xminortick','off','ytick',[])

% Create uicontrols

uicontrol('style','slider','tag','emin','value',emin, ...
   'min',-8,'max',0,'pos',[160 70 120 15],'sliderstep',[1/8 1/8], ...
   'callback','floatgui(1)');
uicontrol('style','slider','tag','t','value',t, ...
   'min',0,'max',8,'pos',[400 70 120 15],'sliderstep',[1/8 1/8], ...
   'callback','floatgui(1)');
uicontrol('style','slider','tag','emax','value',emax, ...
   'min',0,'max',8,'pos',[640 70 120 15],'sliderstep',[1/8 1/8], ...
   'callback','floatgui(1)');
uicontrol('style','text','string',['emin = ' int2str(emin)], ...
   'pos',[160 90 120 20],'fontweight','bold')
uicontrol('style','text','string',['t = ' int2str(t)], ...
   'pos',[400 90 120 20],'fontweight','bold')
uicontrol('style','text','string',['emax = ' int2str(emax)], ...
   'pos',[640 90 120 20],'fontweight','bold')
uicontrol('style','check','string','log scale','value',logscale, ...
   'pos',[390 20 140 20],'fontweight','bold', ...
   'callback','floatgui(1)');
uicontrol('style','push','pos',[800 10 60 20], ...
   'string','close','callback','close(gcf)')

% eps

if fmax > 1
   eps = 2^(-t);
   text(1,0,'|','color','r')
   text(1+eps,0,'|','color','r')
   if eps < 1
      text(1.0,1.5,['eps = 1/' int2str(1/eps)], ...
      'fontweight','bold')
   else
      text(1.0,1.5,'eps = 1','fontweight','bold')
   end
end

% Number of numbers

% Exercise:
% How many "floating point" numbers are in the set?
% Complete this statement.
% text(.9*xmax,2,num2str(???))
