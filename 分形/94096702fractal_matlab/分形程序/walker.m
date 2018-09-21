function walker
% WALKER  Human gait.
% This model, developed by Nikolaus Troje, is a five-term Fourier series
% with vector-valued coefficients that are the principal components for
% data obtained in motion capture experiments involving subjects wearing
% reflective markers walking on a treadmill.  The components, which are
% also known as "postures" or "eigenwalkers", correspond to the static
% position, forward motion, sideways sway, and two hopping/bouncing
% movements that differ in the phase relationship between the upper and
% lower portions of the body.  The postures are also classified by gender.
% Sliders allow you to vary the amount that each component contributes to
% the overall motion.  A slider setting greater than 1.0 overemphasizes
% the characteristic.  Can you see whether positive values of the gender
% coefficient correspond to male or female subjects?
%
% References:
%    http://www.bml.psy.ruhr-uni-bochum.de/Demos
%    http://www.biomotionlab.de/Text/WDP2002_Troje.pdf
%    http://journalofvision.org/2/5/2

clf
shg
set(gcf,'doublebuf','on','color','w','name','Walker','numbertitle','off')
set(gca,'pos',get(gca,'pos')+[0 .07 0 0])

% The body is represented by 15 points in three space, i.e. a vector of
% length 45.  The data consists of F, five vectors describing the average
% female and M, five vectors describing the average male.  Four linked
% segments, indexed by L, are the head, torso, arms, and legs.

% Initial view

load walkers
X = reshape((F(:,1)+M(:,1))/2,15,3);
L = {[1 5],[5 12],[2 3 4 5 6 7 8],[9 10 11 12 13 14 15]};
for k = 1:4
   p(k) = line(X(L{k},1),X(L{k},2),X(L{k},3),'marker','o', ...
      'markersize',10,'linestyle','-','erasemode','background');
end
set(p(1),'tag','head','userdata',zeros(1,3));
axis([-750 750 -750 750 0 1500])
set(gca,'xtick',[],'ytick',[],'ztick',[])
view(160,10)

% Sliders and controls

labels = {'speed','stride','sway','hop','bounce','gender'};
for j = 1:6
   switch j
      case 1, smin = 0; start = 1; smax = 3;
      case 6, smin = -3; start = 0; smax = 3;
      otherwise, smin = -2; start = 1; smax = 2;
   end
   txt = uicontrol('style','text','string',sprintf('%4.2f',start), ...
      'back','w','units','norm','pos',[.16*j-.10 .11 .08 .03]);
   sliders(j) = uicontrol('style','slider','units','norm','back','w', ...
      'pos',[.16*j-.13 .07 .14 .03],'min',smin,'max',smax,'val',start, ...
      'sliderstep',[1/(4*smax),1/(10*smax)],'userdata',txt,'callback',...
      'set(get(gco,''userd''),''str'',sprintf(''%4.2f'',get(gco,''val'')))');
   uicontrol('style','text','string',labels{j},'back','w', ...
      'units','norm','pos',[.16*j-.12 .02 .10 .04])
end
stop = uicontrol('style','toggle','units','norm','pos',[.91 .94 .08 .05], ...
   'backgr','w','fontw','bold','string','stop');
uicontrol('style','radio','units','norm','pos',[.015 .96 .03 .03], ...
   'userdata',H,'background','white', ...
   'callback',['p1 = findobj(''tag'',''head''); if get(gco,''val''),' ...
   'set(p1,''userd'',get(gco,''userd''),''marker'',''none''),' ...
   'else, set(p1,''userd'',zeros(1,3),''marker'',''o''), end']);

% uicontrol('style','text','units','norm','pos',[.72 .25 .25 .08], ...
%    'backgr','white','fontangle','italic', ...
%    'fontsize',get(0,'defaultuicontrolfontsize')-2, ...
%    'string',{'Click on the figure','to change the view'})
cameratoolbar setmode orbit

% Start walkin'...

period = 151.5751;
omega = 2*pi/period;
t = 0;
while get(stop,'value') == 0
   s = cell2mat(get(sliders,'value'));
   t = t + s(1);
   c = [sin(omega*t); cos(omega*t); sin(2*omega*t); cos(2*omega*t)];
   X = (F+M)/2 + s(6)*(F-M)/2;
   w = [1; s(2:5).*c];
   X = reshape(X*w,15,3);
   H = get(p(1),'userdata');
   e = ones(size(H,1),1);
   XH = [H+X(e,:); X(5,:)];
   set(p(1),'xdata',XH(:,1),'ydata',XH(:,2),'zdata',XH(:,3))
   for k = 2:4
      set(p(k),'xdata',X(L{k},1),'ydata',X(L{k},2),'zdata',X(L{k},3));
   end
   pause(.0001)
end;
cameratoolbar close
set(stop,'val',0,'str','close','fontw','bold','callb','close(gcf)')
